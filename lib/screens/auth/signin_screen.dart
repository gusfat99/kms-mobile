// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/models/api_token_model.dart';
import 'package:kms_bpkp_mobile/routes.dart';
import 'package:kms_bpkp_mobile/size.dart';
import 'package:kms_bpkp_mobile/utils.dart';
import 'package:nb_utils/nb_utils.dart';

import 'api/auth_api.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String? email;
  String? password;
  bool isLoading = false;
  //==> Controller
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  // String? _emailValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your email';
  //   }
  //   if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
  //       .hasMatch(value)) {
  //     return 'Please enter a valid email';
  //   }
  //   return null;
  // }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfiguration().init(context);
    return isLoading
        ? loadingIndicator(context)
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 50,
                          child: Image.asset(
                            "assets/images/back_login_01.png",
                            height: 150,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const Expanded(
                          flex: 50,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/back_login_03.png",
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'KMS BPKP',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: mainColor,
                                ),
                          ),
                          20.height,
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                12.height,
                                TextFormField(
                                  controller: emailCont,
                                  onSaved: (newValue) => email = newValue,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: "Username",
                                    contentPadding:
                                        const EdgeInsets.only(left: 20.0),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 0.5, color: mainColor),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  //validator: _emailValidator,
                                ),
                                24.height,
                                Text(
                                  'Kata Sandi',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                12.height,
                                TextFormField(
                                  controller: passwordCont,
                                  onSaved: (newValue) => password = newValue,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    hintText: 'Kata Sandi',
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(left: 20.0),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 0.5, color: mainColor),
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  validator: _passwordValidator,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(forgetPasswordRoute);
                                    },
                                    child: const Text(
                                      'Lupa Kata Sandi?',
                                      style:
                                          TextStyle(color: Color(0xFF3D80DE)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          30.height,
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                AppUtils.hideKeyboard(context);
                                email = emailCont.text;
                                password = passwordCont.text;
                                Map req = {
                                  "username": email,
                                  "password": password
                                };
                                setState(() {
                                  isLoading = true;
                                });

                                await AuthService()
                                    .getAccessToken(req)
                                    .then((value) {
                                  setLogin(value, req);
                                }).catchError((e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  errorMessageModal(
                                      errorTitle: 'Sign In Failed!',
                                      errorMessage:
                                          "Please double check your phone and password!" +
                                              e.toString());
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      mainColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 48)),
                            ),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: whiteColor),
                            ),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              text: "Belum memiliki akun? ",
                              style: const TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Daftar Sekarang',
                                  style: const TextStyle(
                                      color: Color(0xFF3D80DE),
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(signupRoute);
                                    },
                                ),
                              ],
                            ),
                          ),
                          16.height,
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        const Expanded(
                          flex: 25,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 75,
                          child: Image.asset(
                            "assets/images/back_login_02.png",
                            height: 150,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  setLogin(TokenModel value, Map req) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', true);
    prefs.setString('req', jsonEncode(req));
    prefs.setString('token', value.accessToken);
    prefs.setString('profile', jsonEncode(value.user));
    finish(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(mainRoute, (Route<dynamic> route) => false);
  }
}
