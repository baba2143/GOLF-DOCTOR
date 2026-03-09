import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golf_doctor_app/features/auth/presentation/screens/login_screen.dart';
import 'package:golf_doctor_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:golf_doctor_app/features/home/presentation/screens/home_screen.dart';
import 'package:golf_doctor_app/features/pro/presentation/screens/pro_list_screen.dart';
import 'package:golf_doctor_app/features/pro/presentation/screens/pro_detail_screen.dart';
import 'package:golf_doctor_app/features/pro/presentation/screens/pro_registration_screen.dart';
import 'package:golf_doctor_app/features/pro/presentation/screens/pro_dashboard_screen.dart';
import 'package:golf_doctor_app/features/pro/presentation/screens/bank_account_screen.dart';
import 'package:golf_doctor_app/features/pro/presentation/screens/earnings_history_screen.dart';
import 'package:golf_doctor_app/features/diagnosis/presentation/screens/diagnosis_list_screen.dart';
import 'package:golf_doctor_app/features/diagnosis/presentation/screens/diagnosis_detail_screen.dart';
import 'package:golf_doctor_app/features/diagnosis/presentation/screens/create_diagnosis_screen.dart';
import 'package:golf_doctor_app/features/points/presentation/screens/points_screen.dart';
import 'package:golf_doctor_app/features/points/presentation/screens/purchase_points_screen.dart';
import 'package:golf_doctor_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:golf_doctor_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:golf_doctor_app/features/auth/domain/auth_state.dart';
import 'package:golf_doctor_app/app/main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      if (isLoggedIn && isAuthRoute) {
        return '/';
      }

      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),

      // Main app shell with bottom navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/pros',
            builder: (context, state) => const ProListScreen(),
            routes: [
              GoRoute(
                path: ':proId',
                builder: (context, state) => ProDetailScreen(
                  proId: state.pathParameters['proId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/diagnoses',
            builder: (context, state) => const DiagnosisListScreen(),
            routes: [
              GoRoute(
                path: 'create/:proId',
                builder: (context, state) => CreateDiagnosisScreen(
                  proId: state.pathParameters['proId']!,
                ),
              ),
              GoRoute(
                path: ':diagnosisId',
                builder: (context, state) => DiagnosisDetailScreen(
                  diagnosisId: state.pathParameters['diagnosisId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/points',
            builder: (context, state) => const PointsScreen(),
            routes: [
              GoRoute(
                path: 'purchase',
                builder: (context, state) => const PurchasePointsScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                builder: (context, state) => const EditProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Pro-specific routes (outside shell for different navigation)
      GoRoute(
        path: '/pro/register',
        builder: (context, state) => const ProRegistrationScreen(),
      ),
      GoRoute(
        path: '/pro/dashboard',
        builder: (context, state) => const ProDashboardScreen(),
      ),
      GoRoute(
        path: '/pro/bank-account',
        builder: (context, state) => const BankAccountScreen(),
      ),
      GoRoute(
        path: '/pro/earnings',
        builder: (context, state) => const EarningsHistoryScreen(),
      ),
    ],
  );
});
