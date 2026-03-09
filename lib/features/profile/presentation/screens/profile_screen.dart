import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:golf_doctor_app/features/auth/data/auth_repository.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/shared/theme/app_colors.dart';

final userProfileProvider = FutureProvider.autoDispose<Map<String, dynamic>?>((ref) async {
  final userId = SupabaseService.currentUserId;
  if (userId == null) return null;

  final response = await SupabaseService.client
      .from('profiles')
      .select()
      .eq('id', userId)
      .maybeSingle();

  return response;
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = SupabaseService.currentUser;
    final profileAsync = ref.watch(userProfileProvider);
    final isPro = profileAsync.valueOrNull?['role'] == 'pro';

    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColors.surfaceVariant,
                    child: const Icon(Icons.person, size: 48),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.userMetadata?['name'] ?? 'ゲスト',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/profile/edit'),
                    child: const Text('プロフィールを編集'),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Menu items
            _MenuItem(
              icon: Icons.monetization_on,
              title: 'ポイント',
              onTap: () => context.go('/points'),
            ),
            _MenuItem(
              icon: Icons.videocam,
              title: '診断履歴',
              onTap: () => context.go('/diagnoses'),
            ),
            if (isPro)
              _MenuItem(
                icon: Icons.dashboard,
                title: 'プロダッシュボード',
                subtitle: '依頼管理・売上確認',
                onTap: () => context.push('/pro/dashboard'),
              )
            else
              _MenuItem(
                icon: Icons.sports_golf,
                title: 'プロとして登録',
                subtitle: 'プロとして診断を受け付ける',
                onTap: () => context.push('/pro/register'),
              ),

            const Divider(),

            _MenuItem(
              icon: Icons.help_outline,
              title: 'ヘルプ・お問い合わせ',
              onTap: () {
                // TODO: Help
              },
            ),
            _MenuItem(
              icon: Icons.description,
              title: '利用規約',
              onTap: () {
                // TODO: Terms
              },
            ),
            _MenuItem(
              icon: Icons.privacy_tip,
              title: 'プライバシーポリシー',
              onTap: () {
                // TODO: Privacy
              },
            ),

            const Divider(),

            _MenuItem(
              icon: Icons.logout,
              title: 'ログアウト',
              textColor: AppColors.error,
              onTap: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('ログアウト'),
                    content: const Text('ログアウトしてもよろしいですか？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('ログアウト'),
                      ),
                    ],
                  ),
                );

                if (confirmed == true) {
                  await ref.read(authRepositoryProvider).signOut();
                  if (context.mounted) {
                    context.go('/login');
                  }
                }
              },
            ),

            const SizedBox(height: 32),

            // App version
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? textColor;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.textPrimary),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
