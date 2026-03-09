import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:golf_doctor_app/features/pro/data/pro_repository.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/core/services/video_service.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

class ProRegistrationScreen extends ConsumerStatefulWidget {
  const ProRegistrationScreen({super.key});

  @override
  ConsumerState<ProRegistrationScreen> createState() =>
      _ProRegistrationScreenState();
}

class _ProRegistrationScreenState extends ConsumerState<ProRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  int _price = 1000;
  final List<String> _selectedSpecialties = [];
  XFile? _idDocument;
  XFile? _certification;
  final List<XFile> _demoVideos = [];
  bool _isSubmitting = false;
  int _currentStep = 0;

  final List<String> _availableSpecialties = [
    'ドライバー',
    'アイアン',
    'アプローチ',
    'パター',
    'バンカー',
    'スイング全般',
    'フォーム改善',
    '飛距離アップ',
    '初心者指導',
  ];

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument(bool isId) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (isId) {
          _idDocument = image;
        } else {
          _certification = image;
        }
      });
    }
  }

  Future<void> _pickDemoVideo() async {
    if (_demoVideos.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('デモ動画は最大3本までです')),
      );
      return;
    }

    final videoService = ref.read(videoServiceProvider);
    final video = await videoService.pickVideoFromGallery();
    if (video != null) {
      setState(() {
        _demoVideos.add(video);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_idDocument == null || _certification == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('身分証明書と資格証明書をアップロードしてください')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final userId = SupabaseService.currentUserId!;
      final storage = SupabaseService.storage;
      final videoService = ref.read(videoServiceProvider);
      final proRepo = ref.read(proRepositoryProvider);

      // Upload ID document
      final idDocBytes = await _idDocument!.readAsBytes();
      final idDocPath = '$userId/documents/id_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await storage.from('documents').uploadBinary(idDocPath, idDocBytes);
      final idDocUrl = storage.from('documents').getPublicUrl(idDocPath);

      // Upload certification
      final certBytes = await _certification!.readAsBytes();
      final certPath = '$userId/documents/cert_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await storage.from('documents').uploadBinary(certPath, certBytes);
      final certUrl = storage.from('documents').getPublicUrl(certPath);

      // Upload demo videos
      List<String> demoVideoUrls = [];
      for (final video in _demoVideos) {
        final url = await videoService.uploadDemoVideo(filePath: video.path);
        demoVideoUrls.add(url);
      }

      // Create pro profile
      await proRepo.upsertProProfile(
        userId: userId,
        bio: _bioController.text.trim(),
        price: _price,
        specialties: _selectedSpecialties,
        demoVideoUrls: demoVideoUrls.isNotEmpty ? demoVideoUrls : null,
        idDocumentUrl: idDocUrl,
        certificationUrl: certUrl,
      );

      // Update user role
      await proRepo.updateToProRole(userId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('プロ登録申請が完了しました。審査をお待ちください。')),
        );
        context.go('/profile');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラー: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isSubmitting,
      message: '登録中...',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('プロとして登録'),
        ),
        body: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 3) {
                setState(() => _currentStep++);
              } else {
                _submit();
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() => _currentStep--);
              }
            },
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: Text(_currentStep == 3 ? '申請する' : '次へ'),
                    ),
                    if (_currentStep > 0) ...[
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text('戻る'),
                      ),
                    ],
                  ],
                ),
              );
            },
            steps: [
              // Step 1: Basic Info
              Step(
                title: const Text('基本情報'),
                isActive: _currentStep >= 0,
                state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _bioController,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        labelText: '自己紹介',
                        hintText: '経歴や得意分野など、あなたについて教えてください',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '自己紹介を入力してください';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              // Step 2: Price & Specialties
              Step(
                title: const Text('料金・専門'),
                isActive: _currentStep >= 1,
                state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '診断料金',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: _price.toDouble(),
                      min: 500,
                      max: 5000,
                      divisions: 9,
                      label: '¥$_price',
                      onChanged: (value) {
                        setState(() {
                          _price = (value / 500).round() * 500;
                        });
                      },
                    ),
                    Center(
                      child: Text(
                        '¥$_price',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      '専門分野（複数選択可）',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableSpecialties.map((specialty) {
                        final isSelected = _selectedSpecialties.contains(specialty);
                        return FilterChip(
                          label: Text(specialty),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedSpecialties.add(specialty);
                              } else {
                                _selectedSpecialties.remove(specialty);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Step 3: Documents
              Step(
                title: const Text('書類提出'),
                isActive: _currentStep >= 2,
                state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DocumentUploadCard(
                      title: '身分証明書',
                      description: '運転免許証、パスポート等',
                      file: _idDocument,
                      onTap: () => _pickDocument(true),
                    ),
                    const SizedBox(height: 16),
                    _DocumentUploadCard(
                      title: '資格証明書',
                      description: 'PGA資格、レッスンプロ資格等',
                      file: _certification,
                      onTap: () => _pickDocument(false),
                    ),
                  ],
                ),
              ),

              // Step 4: Demo Videos
              Step(
                title: const Text('デモ動画'),
                isActive: _currentStep >= 3,
                state: StepState.indexed,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'デモ動画（任意・最大3本）',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'あなたのレッスンスタイルを紹介する動画をアップロードしてください',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    if (_demoVideos.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _demoVideos.asMap().entries.map((entry) {
                          return Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.play_circle_outline,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _demoVideos.removeAt(entry.key);
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    if (_demoVideos.length < 3) ...[
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _pickDemoVideo,
                        icon: const Icon(Icons.video_library),
                        label: const Text('動画を追加'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentUploadCard extends StatelessWidget {
  final String title;
  final String description;
  final XFile? file;
  final VoidCallback onTap;

  const _DocumentUploadCard({
    required this.title,
    required this.description,
    required this.file,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: file != null
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  file != null ? Icons.check_circle : Icons.upload_file,
                  color: file != null ? AppColors.success : AppColors.textSecondary,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      file != null ? 'アップロード済み' : description,
                      style: TextStyle(
                        color: file != null
                            ? AppColors.success
                            : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
