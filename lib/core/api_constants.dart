// lib/core/api_constants.dart
class ApiConstants {
  static const String baseUrl = 'http://31.97.206.144:4055';

  static const String sendOtp = '$baseUrl/api/users/send-otp';
  static const String verifyOtp = '$baseUrl/api/users/verify-otp';

  // {userId} will be replaced
  static String createProfile(String userId) =>
      '$baseUrl/api/users/createprofile/$userId';
        static String location(String userId) => '$baseUrl/api/users/update-location';

}
