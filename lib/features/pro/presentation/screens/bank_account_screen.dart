import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final bankAccountProvider = FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
  final client = SupabaseService.client;
  final userId = SupabaseService.currentUserId;

  final response = await client
      .from('bank_accounts')
      .select()
      .eq('pro_id', userId!)
      .maybeSingle();

  return response;
});

class BankAccountScreen extends ConsumerStatefulWidget {
  const BankAccountScreen({super.key});

  @override
  ConsumerState<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends ConsumerState<BankAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _branchNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountHolderController = TextEditingController();
  String _accountType = 'ordinary';
  bool _isSubmitting = false;
  bool _isLoaded = false;

  @override
  void dispose() {
    _bankNameController.dispose();
    _branchNameController.dispose();
    _accountNumberController.dispose();
    _accountHolderController.dispose();
    super.dispose();
  }

  void _loadExistingData(Map<String, dynamic>? data) {
    if (data != null && !_isLoaded) {
      _bankNameController.text = data['bank_name'] ?? '';
      _branchNameController.text = data['branch_name'] ?? '';
      _accountNumberController.text = data['account_number'] ?? '';
      _accountHolderController.text = data['account_holder'] ?? '';
      _accountType = data['account_type'] ?? 'ordinary';
      _isLoaded = true;
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final client = SupabaseService.client;
      final userId = SupabaseService.currentUserId!;

      await client.from('bank_accounts').upsert({
        'pro_id': userId,
        'bank_name': _bankNameController.text.trim(),
        'branch_name': _branchNameController.text.trim(),
        'account_type': _accountType,
        'account_number': _accountNumberController.text.trim(),
        'account_holder': _accountHolderController.text.trim(),
      }, onConflict: 'pro_id');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('振込先を保存しました')),
        );
        Navigator.pop(context);
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
    final bankAccountAsync = ref.watch(bankAccountProvider);

    return LoadingOverlay(
      isLoading: _isSubmitting,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('振込先設定'),
        ),
        body: bankAccountAsync.when(
          loading: () => const LoadingIndicator(),
          error: (e, s) => Center(child: Text('エラー: $e')),
          data: (data) {
            _loadExistingData(data);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '振込先口座情報',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '売上はこちらの口座に振り込まれます',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Bank name
                    TextFormField(
                      controller: _bankNameController,
                      decoration: const InputDecoration(
                        labelText: '銀行名',
                        hintText: '例: 三菱UFJ銀行',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '銀行名を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Branch name
                    TextFormField(
                      controller: _branchNameController,
                      decoration: const InputDecoration(
                        labelText: '支店名',
                        hintText: '例: 渋谷支店',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '支店名を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Account type
                    const Text(
                      '口座種別',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('普通'),
                            value: 'ordinary',
                            groupValue: _accountType,
                            onChanged: (value) {
                              setState(() {
                                _accountType = value!;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('当座'),
                            value: 'current',
                            groupValue: _accountType,
                            onChanged: (value) {
                              setState(() {
                                _accountType = value!;
                              });
                            },
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Account number
                    TextFormField(
                      controller: _accountNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '口座番号',
                        hintText: '例: 1234567',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '口座番号を入力してください';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return '数字のみ入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Account holder
                    TextFormField(
                      controller: _accountHolderController,
                      decoration: const InputDecoration(
                        labelText: '口座名義（カタカナ）',
                        hintText: '例: ヤマダ タロウ',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '口座名義を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _save,
                        child: const Text('保存'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
