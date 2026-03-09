import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final earningsHistoryProvider =
    FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final client = SupabaseService.client;
  final userId = SupabaseService.currentUserId;

  final response = await client
      .from('pro_earnings')
      .select('*, diagnosis:diagnoses(*, user:profiles(name))')
      .eq('pro_id', userId!)
      .order('created_at', ascending: false);

  return List<Map<String, dynamic>>.from(response);
});

final earningsSummaryProvider =
    FutureProvider.autoDispose<Map<String, int>>((ref) async {
  final client = SupabaseService.client;
  final userId = SupabaseService.currentUserId;

  final response = await client
      .from('pro_earnings')
      .select('net_amount, status')
      .eq('pro_id', userId!);

  int totalEarnings = 0;
  int pendingAmount = 0;
  int paidAmount = 0;

  for (final row in response as List) {
    final amount = row['net_amount'] as int;
    totalEarnings += amount;
    if (row['status'] == 'pending') {
      pendingAmount += amount;
    } else {
      paidAmount += amount;
    }
  }

  return {
    'total': totalEarnings,
    'pending': pendingAmount,
    'paid': paidAmount,
  };
});

class EarningsHistoryScreen extends ConsumerWidget {
  const EarningsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(earningsHistoryProvider);
    final summaryAsync = ref.watch(earningsSummaryProvider);
    final dateFormat = DateFormat('yyyy/MM/dd');

    return Scaffold(
      appBar: AppBar(
        title: const Text('売上履歴'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(earningsHistoryProvider);
          ref.invalidate(earningsSummaryProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Summary card
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: summaryAsync.when(
                  loading: () => const SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (e, s) => Text('エラー: $e'),
                  data: (summary) => Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryItem(
                              label: '累計売上',
                              amount: summary['total']!,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _SummaryItem(
                              label: '未振込',
                              amount: summary['pending']!,
                              color: AppColors.warning,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _SummaryItem(
                              label: '振込済み',
                              amount: summary['paid']!,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // History list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Text(
                      '取引履歴',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              historyAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: LoadingIndicator(),
                ),
                error: (e, s) => Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('エラー: $e'),
                ),
                data: (history) {
                  if (history.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(48),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 64,
                              color: AppColors.textSecondary,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '取引履歴がありません',
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
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final earning = history[index];
                      final diagnosis = earning['diagnosis'];
                      final user = diagnosis?['user'];
                      final isPaid = earning['status'] == 'paid';
                      final createdAt = DateTime.parse(earning['created_at']);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    user?['name'] ?? '不明なユーザー',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isPaid
                                          ? AppColors.success
                                              .withValues(alpha: 0.1)
                                          : AppColors.warning
                                              .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      isPaid ? '振込済み' : '未振込',
                                      style: TextStyle(
                                        color: isPaid
                                            ? AppColors.success
                                            : AppColors.warning,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    dateFormat.format(createdAt),
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Divider(height: 1),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '診断料金',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '¥${earning['gross_amount']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '手数料',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '-¥${earning['platform_fee']}',
                                        style: const TextStyle(
                                          color: AppColors.error,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        '受取額',
                                        style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '¥${earning['net_amount']}',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final int amount;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '¥${amount.toLocaleString()}',
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
