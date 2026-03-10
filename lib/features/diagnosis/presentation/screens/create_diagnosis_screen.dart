import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:golf_doctor_app/features/pro/data/pro_repository.dart';
import 'package:golf_doctor_app/features/points/data/points_repository.dart';
import 'package:golf_doctor_app/features/diagnosis/data/diagnosis_repository.dart';
import 'package:golf_doctor_app/features/diagnosis/presentation/screens/diagnosis_list_screen.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';
import 'package:golf_doctor_app/core/models/profile.dart';

class CreateDiagnosisScreen extends ConsumerStatefulWidget {
  final String proId;

  const CreateDiagnosisScreen({super.key, required this.proId});

  @override
  ConsumerState<CreateDiagnosisScreen> createState() =>
      _CreateDiagnosisScreenState();
}

class _CreateDiagnosisScreenState extends ConsumerState<CreateDiagnosisScreen> {
  final _messageController = TextEditingController();
  XFile? _selectedVideo;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );

    if (video != null) {
      setState(() {
        _selectedVideo = video;
      });
    }
  }

  Future<void> _recordVideo() async {
    final picker = ImagePicker();
    final video = await picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 60),
    );

    if (video != null) {
      setState(() {
        _selectedVideo = video;
      });
    }
  }

  Future<void> _submit() async {
    if (_selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('動画を選択してください')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final proRepo = ref.read(proRepositoryProvider);
      final diagnosisRepo = ref.read(diagnosisRepositoryProvider);
      final pointsRepo = ref.read(pointsRepositoryProvider);

      // Get pro price
      final pro = await proRepo.getProProfile(widget.proId);
      if (pro == null) throw Exception('プロが見つかりません');

      // Check balance
      final balance = await pointsRepo.getBalance();
      if (balance < pro.price) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('ポイント不足'),
              content: Text(
                '診断には${pro.price}ポイント必要です。\n現在の残高: ${balance}ポイント',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.go('/points/purchase');
                  },
                  child: const Text('ポイントを購入'),
                ),
              ],
            ),
          );
        }
        return;
      }

      // Upload video to storage (works on both web and mobile)
      final bytes = await _selectedVideo!.readAsBytes();
      final videoUrl = await diagnosisRepo.uploadVideoBytes(
        bytes: bytes,
        fileName: _selectedVideo!.name,
      );

      // Create diagnosis with uploaded video URL
      await diagnosisRepo.createDiagnosis(
        proId: widget.proId,
        price: pro.price,
        videoUrl: videoUrl,
        text: _messageController.text.trim().isNotEmpty
            ? _messageController.text.trim()
            : null,
      );

      if (mounted) {
        // 診断一覧をリフレッシュ
        refreshDiagnoses(ref);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('診断を依頼しました')),
        );
        context.go('/diagnoses');
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
    final proAsync = ref.watch(proDetailProvider(widget.proId));
    final balanceAsync = ref.watch(pointBalanceProvider);

    return LoadingOverlay(
      isLoading: _isSubmitting,
      message: '診断を依頼中...',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('診断を依頼'),
        ),
        body: proAsync.when(
          loading: () => const LoadingIndicator(),
          error: (error, stack) => Center(child: Text('エラー: $error')),
          data: (pro) {
            if (pro == null) {
              return const Center(child: Text('プロが見つかりません'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pro info card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.surfaceVariant,
                            child: const Icon(Icons.person),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pro.profile?.name ?? 'プロ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: AppColors.starFilled,
                                    ),
                                    Text(
                                      ' ${pro.averageRating.toStringAsFixed(1)}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '診断料金',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              Text(
                                '¥${pro.price}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Balance info
                  balanceAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (e, s) => const SizedBox.shrink(),
                    data: (balance) => Card(
                      color: balance >= pro.price
                          ? AppColors.success.withValues(alpha: 0.1)
                          : AppColors.warning.withValues(alpha: 0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              balance >= pro.price
                                  ? Icons.check_circle
                                  : Icons.warning,
                              color: balance >= pro.price
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '現在の残高: ${balance}ポイント',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (balance < pro.price)
                              TextButton(
                                onPressed: () => context.go('/points/purchase'),
                                child: const Text('購入'),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Video selection
                  const Text(
                    'スイング動画',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '診断してほしいスイングの動画を選択または撮影してください（最大60秒）',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (_selectedVideo != null) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 32,
                      height: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_circle_outline,
                                    size: 64,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '動画を選択しました',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: const Icon(Icons.close, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _selectedVideo = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _pickVideo,
                            icon: const Icon(Icons.photo_library),
                            label: const Text('選択'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _recordVideo,
                            icon: const Icon(Icons.videocam),
                            label: const Text('撮影'),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),

                  // Message
                  const Text(
                    'メッセージ（任意）',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _messageController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: '悩んでいることや、特に見てほしいポイントがあれば記入してください',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Info
                  Card(
                    color: AppColors.info.withValues(alpha: 0.1),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: AppColors.info),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '診断について',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '・プロは48時間以内に回答します\n'
                                  '・回答後、3回まで追加質問が可能です\n'
                                  '・期限内に回答がない場合はポイントが返還されます',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _selectedVideo != null ? _submit : null,
              child: Text(
                proAsync.valueOrNull != null
                    ? '${proAsync.value!.price}ポイントで診断を依頼'
                    : '診断を依頼',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Import these providers from other files
final proDetailProvider =
    FutureProvider.autoDispose.family<ProProfile?, String>((ref, proId) async {
  final repo = ref.read(proRepositoryProvider);
  return repo.getProProfile(proId);
});

final pointBalanceProvider = FutureProvider.autoDispose<int>((ref) async {
  final repo = ref.read(pointsRepositoryProvider);
  return repo.getBalance();
});
