import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:golf_doctor_app/core/config/env_config.dart';
import 'package:golf_doctor_app/core/config/routes.dart';
import 'package:golf_doctor_app/core/services/supabase_service.dart';
import 'package:golf_doctor_app/shared/theme/app_theme.dart';
import 'package:golf_doctor_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Supabase
  await SupabaseService.initialize();

  // Initialize Stripe (not supported on web)
  if (!kIsWeb) {
    Stripe.publishableKey = EnvConfig.stripePublishableKey;
    Stripe.merchantIdentifier = EnvConfig.stripeMerchantId;
    await Stripe.instance.applySettings();
  }

  runApp(
    const ProviderScope(
      child: GolfDoctorApp(),
    ),
  );
}

class GolfDoctorApp extends ConsumerWidget {
  const GolfDoctorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'GOLF DOCTOR',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}
