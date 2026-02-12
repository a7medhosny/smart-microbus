import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {
  static String? extractUserId(String token) {
    try {
      Map<String, dynamic> decoded = JwtDecoder.decode(token);
      return decoded['sub'] as String?;
    } catch (e) {
      return null;
    }
  }

  static String extractRoles(String token) {
    try {
      Map<String, dynamic> decoded = JwtDecoder.decode(token);
      String role = 'Passenger';

      final rolesClaim =
          decoded['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

      if (rolesClaim == null) return role;

      if (rolesClaim is List) {
        role = rolesClaim[0];
      }

      if (rolesClaim is String) {
        role = rolesClaim;
      }

      return role;
    } catch (e) {
      debugPrint("Error in Extract Roles ${e.toString()}");
      return '';
    }
  }
}
