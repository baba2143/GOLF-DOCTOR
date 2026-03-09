import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:golf_doctor_app/features/pro/data/pro_repository.dart';
import 'package:golf_doctor_app/core/models/profile.dart';
import 'package:golf_doctor_app/core/models/review.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final proDetailProvider = FutureProvider.autoDispose
    .family<ProProfile?, String>((ref, proId) async {
  final repo = ref.read(proRepositoryProvider);
  return repo.getProProfile(proId);
});

final proReviewsProvider =
    FutureProvider.autoDispose.family<List<Review>, String>((ref, proId) async {
  final repo = ref.read(proRepositoryProvider);
  return repo.getProReviews(proId);
});

class ProDetailScreen extends ConsumerWidget {
  final String proId;

  const ProDetailScreen({super.key, required this.proId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proAsync = ref.watch(proDetailProvider(proId));
    final reviewsAsync = ref.watch(proReviewsProvider(proId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロ詳細'),
      ),
      body: proAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(child: Text('エラー: $error')),
        data: (pro) {
          if (pro == null) {
            return const Center(child: Text('プロが見つかりません'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  color: AppColors.primary,
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white,
                        backgroundImage: pro.profile?.avatarUrl != null
                            ? CachedNetworkImageProvider(pro.profile!.avatarUrl!)
                            : null,
                        child: pro.profile?.avatarUrl == null
                            ? const Icon(Icons.person, size: 48)
                            : null,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pro.profile?.name ?? 'プロ',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.starFilled,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  pro.averageRating.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  ' (${pro.reviewCount}件のレビュー)',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '診断料金',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '¥${pro.price}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Bio
                      if (pro.bio != null && pro.bio!.isNotEmpty) ...[
                        const Text(
                          '自己紹介',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pro.bio!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Specialties
                      if (pro.specialties != null &&
                          pro.specialties!.isNotEmpty) ...[
                        const Text(
                          '専門分野',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: pro.specialties!.map((s) {
                            return Chip(
                              label: Text(s),
                              backgroundColor:
                                  AppColors.primaryLight.withValues(alpha: 0.2),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Demo Videos
                      if (pro.demoVideoUrls != null &&
                          pro.demoVideoUrls!.isNotEmpty) ...[
                        const Text(
                          'デモ動画',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: pro.demoVideoUrls!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 160,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    size: 48,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Reviews
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'レビュー',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: All reviews
                            },
                            child: const Text('すべて見る'),
                          ),
                        ],
                      ),
                      reviewsAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, s) => Text('エラー: $e'),
                        data: (reviews) {
                          if (reviews.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'まだレビューはありません',
                                style:
                                    TextStyle(color: AppColors.textSecondary),
                              ),
                            );
                          }

                          return Column(
                            children: reviews.take(3).map((review) {
                              return _ReviewCard(review: review);
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: proAsync.valueOrNull != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/diagnoses/create/$proId');
                  },
                  child: const Text('このプロに診断を依頼する'),
                ),
              ),
            )
          : null,
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.surfaceVariant,
                  child: Text(
                    (review.user?.name ?? 'U')[0].toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.user?.name ?? 'ユーザー',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            size: 14,
                            color: AppColors.starFilled,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (review.comment != null && review.comment!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                review.comment!,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
