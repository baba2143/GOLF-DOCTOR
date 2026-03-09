/// Environment configuration for GOLF DOCTOR app
class EnvConfig {
  EnvConfig._();

  // Supabase
  static const String supabaseUrl = 'https://zukgydkjsnrpfitgbcxz.supabase.co';

  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp1a2d5ZGtqc25ycGZpdGdiY3h6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMwMjg2ODMsImV4cCI6MjA4ODYwNDY4M30.126bOqhxBEUQwCceaT3IJURSlow1E4U6k6QLgMql_0w';

  // Stripe
  static const String stripePublishableKey = 'pk_test_51T8xOBPvATUTnv0gNeWi5JF6xpZ8XhuFvW7Abx7Aqr6U7578gBd5Pen27fx20qVAszL9V2hBwjrDkLEyTipgGb0f00YlQ6kQiw';

  static const String stripeMerchantId = 'merchant.com.golfdoctor.app';

  // App Settings
  static const int pointExpirationMonths = 6;
  static const int diagnosisDeadlineHours = 48;
  static const int maxFollowups = 3;
  static const int platformFeePercent = 20;

  // Video Settings
  static const int maxVideoSizeMB = 100;
  static const int maxVideoDurationSeconds = 60;
}
