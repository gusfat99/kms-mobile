import 'dart:convert';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tokenJson = prefs.getString('token');
  return tokenJson;
}

Future<User> getProfileShared() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? tokenJson = prefs.getString('profile');
  Map<String, dynamic> tokenMap =
      jsonDecode(tokenJson!) as Map<String, dynamic>;
  User profile = User.fromJson(tokenMap);
  return profile;
}
