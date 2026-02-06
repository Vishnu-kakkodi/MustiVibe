import 'dart:convert';
import 'package:dating_app/models/Coin/user_coins_model.dart';
import 'package:http/http.dart' as http;
import 'package:dating_app/core/api_constants.dart';

class CoinsService {
  static Future<UserCoinsModel> getUserCoins(String userId) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConstants.baseUrl}/api/users/getusercoins/$userId',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print("oooooooooooooooooooooooooooooooooo${response.body}");

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return UserCoinsModel.fromJson(body);
    } else {
      throw Exception('Failed to fetch user coins');
    }
  }
}
