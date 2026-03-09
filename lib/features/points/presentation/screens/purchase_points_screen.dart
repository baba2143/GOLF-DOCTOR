import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:golf_doctor_app/features/points/data/points_repository.dart';
import 'package:golf_doctor_app/core/models/points.dart';
import 'package:golf_doctor_app/shared/widgets/loading_overlay.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

class PurchasePointsScreen extends ConsumerStatefulWidget {
  const PurchasePointsScreen({super.key});

  @override
  ConsumerState<PurchasePointsScreen> createState() =>
      _PurchasePointsScreenState();
}

class _PurchasePointsScreenState extends ConsumerState<PurchasePointsScreen> {
  PointPackage? _selectedPackage;
  bool _isLoading = false;

  Future<void> _purchase() async {
    if (_selectedPackage == null) return;

    setState(() => _isLoading = true);

    try {
      final repo = ref.read(pointsRepositoryProvider);
      final checkoutUrl = await repo.createCheckoutSession(
        package: _selectedPackage!,
      );

      // Open Stripe checkout in browser
      final uri = Uri.parse(checkoutUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch checkout URL');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラー: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      message: '決済ページを開いています...',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ポイント購入'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'パッケージを選択',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Package options
              ...PointPackage.packages.map((package) {
                final isSelected = _selectedPackage == package;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _PackageCard(
                    package: package,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedPackage = package;
                      });
                    },
                  ),
                );
              }),

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
                              'ポイントについて',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '・ポイントは購入日から6ヶ月間有効です\n'
                              '・ボーナスポイントも同時に付与されます\n'
                              '・購入後の返金はできません',
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
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _selectedPackage != null ? _purchase : null,
              child: Text(
                _selectedPackage != null
                    ? '¥${_selectedPackage!.priceJpy}で購入'
                    : 'パッケージを選択してください',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final PointPackage package;
  final bool isSelected;
  final VoidCallback onTap;

  const _PackageCard({
    required this.package,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Radio indicator
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),

              // Points info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${package.points}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        const Text(
                          ' ポイント',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (package.bonusPoints > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.warning.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '+${package.bonusPoints}ボーナス',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.warning,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (package.bonusPoints > 0)
                      Text(
                        '合計 ${package.totalPoints} ポイント',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),

              // Price
              Text(
                '¥${package.priceJpy}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
