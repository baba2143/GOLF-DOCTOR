import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:golf_doctor_app/features/points/data/points_repository.dart';
import 'package:golf_doctor_app/core/models/points.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final pointBalanceProvider = FutureProvider.autoDispose<int>((ref) async {
  final repo = ref.read(pointsRepositoryProvider);
  return repo.getBalance();
});

final pointTransactionsProvider =
    FutureProvider.autoDispose<List<PointTransaction>>((ref) async {
  final repo = ref.read(pointsRepositoryProvider);
  return repo.getTransactions();
});

class PointsScreen extends ConsumerWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(pointBalanceProvider);
    final transactionsAsync = ref.watch(pointTransactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポイント'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(pointBalanceProvider);
          ref.invalidate(pointTransactionsProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Balance card
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      '現在の残高',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    balanceAsync.when(
                      loading: () => const SizedBox(
                        height: 48,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      error: (e, s) => const Text(
                        '---',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      data: (balance) => Text(
                        '$balance',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'ポイント',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.go('/points/purchase'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      child: const Text('ポイントを購入'),
                    ),
                  ],
                ),
              ),

              // Transaction history
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '取引履歴',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Full history
                      },
                      child: const Text('すべて見る'),
                    ),
                  ],
                ),
              ),

              transactionsAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(32),
                  child: LoadingIndicator(),
                ),
                error: (e, s) => Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text('エラー: $e'),
                ),
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(height: 16),
                          Text(
                            '取引履歴がありません',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return _TransactionTile(
                        transaction: transactions[index],
                      );
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

class _TransactionTile extends StatelessWidget {
  final PointTransaction transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');
    final isPositive =
        transaction.type == TransactionType.purchase ||
        transaction.type == TransactionType.bonus ||
        transaction.type == TransactionType.refund;

    IconData icon;
    Color color;
    String label;

    switch (transaction.type) {
      case TransactionType.purchase:
        icon = Icons.add_circle;
        color = AppColors.success;
        label = '購入';
        break;
      case TransactionType.bonus:
        icon = Icons.card_giftcard;
        color = AppColors.info;
        label = 'ボーナス';
        break;
      case TransactionType.consume:
        icon = Icons.remove_circle;
        color = AppColors.error;
        label = '使用';
        break;
      case TransactionType.refund:
        icon = Icons.replay;
        color = AppColors.success;
        label = '返金';
        break;
      case TransactionType.expire:
        icon = Icons.timer_off;
        color = AppColors.textSecondary;
        label = '失効';
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(
        transaction.description ?? label,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        dateFormat.format(transaction.createdAt),
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Text(
        '${isPositive ? '+' : ''}${transaction.amount}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: isPositive ? AppColors.success : AppColors.error,
        ),
      ),
    );
  }
}
