import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kms_bpkp_mobile/routes.dart';
import 'package:kms_bpkp_mobile/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLogin = prefs.getBool('login');
  isLogin ??= false;
  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      initialRoute: isLogin ? mainRoute : signinRoute,
      routes: routes,
      theme: theme()));
}