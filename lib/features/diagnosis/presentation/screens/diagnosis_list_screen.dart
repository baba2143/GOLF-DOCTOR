import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:golf_doctor_app/features/diagnosis/data/diagnosis_repository.dart';
import 'package:golf_doctor_app/core/models/diagnosis.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final diagnosesProvider =
    FutureProvider.autoDispose<List<Diagnosis>>((ref) async {
  final repo = ref.read(diagnosisRepositoryProvider);
  return repo.getUserDiagnoses();
});

class DiagnosisListScreen extends ConsumerWidget {
  const DiagnosisListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosesAsync = ref.watch(diagnosesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('診断履歴'),
      ),
      body: diagnosesAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('エラーが発生しました'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(diagnosesProvider),
                child: const Text('再読み込み'),
              ),
            ],
          ),
        ),
        data: (diagnoses) {
          if (diagnoses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.videocam_off,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'まだ診断がありません',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.go('/pros'),
                    child: const Text('プロを探す'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(diagnosesProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: diagnoses.length,
              itemBuilder: (context, index) {
                final diagnosis = diagnoses[index];
                return _DiagnosisCard(diagnosis: diagnosis);
              },
            ),
          );
        },
      ),
    );
  }
}

class _DiagnosisCard extends StatelessWidget {
  final Diagnosis diagnosis;

  const _DiagnosisCard({required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
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
                  Expanded(
                    child: Text(
                      diagnosis.pro?.name ?? 'プロ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _StatusBadge(status: diagnosis.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '依頼日: ${dateFormat.format(diagnosis.createdAt)}',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              if (diagnosis.status == DiagnosisStatus.pending) ...[
                const SizedBox(height: 4),
                Text(
                  '期限: ${dateFormat.format(diagnosis.deadlineAt)}',
                  style: TextStyle(
                    color: diagnosis.deadlineAt.isBefore(
                            DateTime.now().add(const Duration(hours: 12)))
                        ? AppColors.warning
                        : AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (diagnosis.status == DiagnosisStatus.answered) ...[
                const SizedBox(height: 4),
                Text(
                  '回答日: ${dateFormat.format(diagnosis.answeredAt!)}',
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 12,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¥${diagnosis.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  if (diagnosis.status == DiagnosisStatus.answered)
                    Text(
                      '追加質問: ${diagnosis.followupCount}/${diagnosis.maxFollowups}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final DiagnosisStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case DiagnosisStatus.pending:
        color = AppColors.statusPending;
        label = '回答待ち';
        break;
      case DiagnosisStatus.inProgress:
        color = AppColors.statusInProgress;
        label = '回答中';
        break;
      case DiagnosisStatus.answered:
        color = AppColors.statusAnswered;
        label = '回答済み';
        break;
      case DiagnosisStatus.expired:
        color = AppColors.statusExpired;
        label = '期限切れ';
        break;
      case DiagnosisStatus.refunded:
        color = AppColors.statusRefunded;
        label = '返金済み';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
