/// TEMPLATE FILE: Copy this file to api_keys.dart and replace placeholder values with real keys
///
/// This is a template file for API keys.
/// 1. Make a copy of this file and rename it to api_keys.dart
/// 2. Replace the placeholder values with your actual API keys
/// 3. The app will crash at startup if api_keys.dart is not properly configured
///
/// DO NOT modify this template file directly.
/// DO NOT commit your real api_keys.dart file to version control.

class ApiKeys {
  /// Google Places API key for location services
  /// Replace with your actual API key from Google Cloud Console
  static const String googlePlacesApiKey = "YOUR_GOOGLE_PLACES_API_KEY_HERE";

  /// Add other API keys as needed

  /// Validates that all API keys have been properly replaced with real values
  static bool validateKeys() {
    if (googlePlacesApiKey == "YOUR_GOOGLE_PLACES_API_KEY_HERE") {
      throw Exception(
          "API keys not configured! Please copy api_keys_template.dart to api_keys.dart "
          "and replace placeholder values with real API keys.");
    }
    return true;
  }
}
