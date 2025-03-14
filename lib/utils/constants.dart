import 'dart:io';
import 'dart:ui';

class Constants {
  // App Name
  static String appName = 'Demo';

  // Device type
  static String deviceType = (Platform.isAndroid) ? 'android' : 'ios';

  // Static Device Token
  static String deviceToken = 'godisalmighty';

  // Preferred Country in Nationality
  static String defaultCountry = 'US';

  // Length and Error Messages of Password and Email
  static int passwordLen = 8;

  // All Language list in App
  // static List<LanguageModel> languages = [
  //   LanguageModel(
  //       languageName: 'English', countryCode: 'US', languageCode: 'en'),
  // ];

  // Default Language in App
  static Locale defaultLanguage = const Locale('en', 'US');

}
