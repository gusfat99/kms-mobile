import 'package:flutter/widgets.dart';
import 'package:kms_bpkp_mobile/screens/auth/signin_screen.dart';
import 'package:kms_bpkp_mobile/screens/main/main_screen.dart';
import 'package:kms_bpkp_mobile/screens/notification/notification_screen.dart';

import 'screens/akun/pages/dokumen_screen.dart';
import 'screens/akun/pages/pengaturan_profile_screen.dart';
import 'screens/akun/pages/ubah_sandi_confirm_screen.dart';
import 'screens/akun/pages/ubah_sandi_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/auth/signup_password_screen.dart';
import 'screens/auth/signup_screen.dart';

String signinRoute = "sign_in_route";
String forgetPasswordRoute = "forget_password_route";
String signupRoute = "sign_up_route";
String signupPasswordRoute = "signupPasswordRoute";
String ubahSandiKonfirmRoute = "ubahSandiKonfirmRoute";
String mainRoute = "main_route";
String errorRoute = "error_route";
String notificationRoute = "notification_route";
String pengaturanProfileRoute = "pengaturan_profile_route";
String ubahSandiRoute = "ubah_sandi_route";
String dokumenRoute = "dokumen_route";

final Map<String, WidgetBuilder> routes = {
  signinRoute: (context) => const SigninScreen(),
  forgetPasswordRoute: (context) => const ForgetPasswordScreen(),
  signupRoute: (context) => const SignupScreen(),
  signupPasswordRoute: (context) => const SignUpPasswordScreen(),
  ubahSandiKonfirmRoute: (context) => const UbahSandiConfirmScreen(),
  mainRoute: (context) => const MainScreen(),
  notificationRoute: (context) => const NotificationScreen(),
  pengaturanProfileRoute: (context) => const PengaturanProfileScreen(),
  ubahSandiRoute: (context) => const UbahSandiScreen(),
  dokumenRoute: (context) => const DokumenScreen(),
};
