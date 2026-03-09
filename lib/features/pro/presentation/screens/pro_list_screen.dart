import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:golf_doctor_app/features/pro/data/pro_repository.dart';
import 'package:golf_doctor_app/core/models/profile.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final prosProvider = FutureProvider.autoDispose<List<ProProfile>>((ref) async {
  final repo = ref.read(proRepositoryProvider);
  return repo.getPublicPros();
});

class ProListScreen extends ConsumerWidget {
  const ProListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prosAsync = ref.watch(prosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロを探す'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Filter dialog
            },
          ),
        ],
      ),
      body: prosAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('エラーが発生しました: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(prosProvider),
                child: const Text('再読み込み'),
              ),
            ],
          ),
        ),
        data: (pros) {
          if (pros.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_search,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'まだプロが登録されていません',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(prosProvider);
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pros.length,
              itemBuilder: (context, index) {
                final pro = pros[index];
                return _ProCard(pro: pro);
              },
            ),
          );
        },
      ),
    );
  }
}

class _ProCard extends StatelessWidget {
  final ProProfile pro;

  const _ProCard({required this.pro});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.go('/pros/${pro.userId}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.surfaceVariant,
                backgroundImage: pro.profile?.avatarUrl != null
                    ? CachedNetworkImageProvider(pro.profile!.avatarUrl!)
                    : null,
                child: pro.profile?.avatarUrl == null
                    ? const Icon(Icons.person, size: 36)
                    : null,
              ),
              const SizedBox(width: 16),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pro.profile?.name ?? 'プロ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: AppColors.starFilled,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          pro.averageRating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' (${pro.reviewCount}件)',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Specialties
                    if (pro.specialties != null && pro.specialties!.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: pro.specialties!.take(3).map((s) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              s,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 8),
                    // Price
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
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
