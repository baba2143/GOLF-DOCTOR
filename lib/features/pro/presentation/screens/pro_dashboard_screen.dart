import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:golf_doctor_app/features/diagnosis/data/diagnosis_repository.dart';
import 'package:golf_doctor_app/core/models/diagnosis.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final proDiagnosesProvider =
    FutureProvider.autoDispose<List<Diagnosis>>((ref) async {
  final repo = ref.read(diagnosisRepositoryProvider);
  return repo.getUserDiagnoses();
});

final proEarningsProvider = FutureProvider.autoDispose<int>((ref) async {
  final client = SupabaseService.client;
  final userId = SupabaseService.currentUserId;

  final response = await client
      .from('pro_earnings')
      .select('net_amount')
      .eq('pro_id', userId!)
      .eq('status', 'pending');

  int total = 0;
  for (final row in response as List) {
    total += row['net_amount'] as int;
  }
  return total;
});

class ProDashboardScreen extends ConsumerWidget {
  const ProDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosesAsync = ref.watch(proDiagnosesProvider);
    final earningsAsync = ref.watch(proEarningsProvider);
    final currentUserId = SupabaseService.currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロダッシュボード'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.account_balance),
                        title: const Text('振込先設定'),
                        onTap: () {
                          Navigator.pop(context);
                          context.push('/pro/bank-account');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('プロフィール編集'),
                        onTap: () {
                          Navigator.pop(context);
                          context.push('/profile/edit');
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.receipt_long),
                        title: const Text('売上履歴'),
                        onTap: () {
                          Navigator.pop(context);
                          context.push('/pro/earnings');
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(proDiagnosesProvider);
          ref.invalidate(proEarningsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Earnings card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '未振込売上',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    earningsAsync.when(
                      loading: () => const Text(
                        '---',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      error: (e, s) => const Text(
                        '---',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                      data: (earnings) => Text(
                        '¥${earnings.toLocaleString()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () => context.push('/pro/earnings'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                          child: const Text('売上履歴'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () => context.push('/pro/bank-account'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                          ),
                          child: const Text('振込先設定'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Pending diagnoses
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '回答待ちの依頼',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/diagnoses'),
                      child: const Text('すべて見る'),
                    ),
                  ],
                ),
              ),

              diagnosesAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: LoadingIndicator(),
                ),
                error: (e, s) => Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('エラー: $e'),
                ),
                data: (diagnoses) {
                  final pendingDiagnoses = diagnoses
                      .where((d) =>
                          d.proId == currentUserId &&
                          d.status == DiagnosisStatus.pending)
                      .toList();

                  if (pendingDiagnoses.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 48,
                              color: AppColors.success,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '回答待ちの依頼はありません',
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: pendingDiagnoses.length,
                    itemBuilder: (context, index) {
                      final diagnosis = pendingDiagnoses[index];
                      return _PendingDiagnosisCard(diagnosis: diagnosis);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PendingDiagnosisCard extends StatelessWidget {
  final Diagnosis diagnosis;

  const _PendingDiagnosisCard({required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM/dd HH:mm');
    final deadline = diagnosis.deadlineAt;
    final remaining = deadline.difference(DateTime.now());
    final isUrgent = remaining.inHours < 12;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isUrgent
            ? const BorderSide(color: AppColors.warning, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => context.go('/diagnoses/${diagnosis.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    diagnosis.user?.name ?? 'ユーザー',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (isUrgent)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            size: 14,
                            color: AppColors.warning,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '期限間近',
                            style: TextStyle(
                              color: AppColors.warning,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '期限: ${dateFormat.format(deadline)}',
                    style: TextStyle(
                      color: isUrgent ? AppColors.warning : AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '¥${diagnosis.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/diagnoses/${diagnosis.id}'),
                  child: const Text('回答する'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on int {
  String toLocaleString() {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
