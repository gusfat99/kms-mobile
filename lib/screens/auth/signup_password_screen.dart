import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpPasswordScreen extends StatefulWidget {
  const SignUpPasswordScreen({super.key});

  @override
  State<SignUpPasswordScreen> createState() => _SignUpPasswordScreenState();
}

class _SignUpPasswordScreenState extends State<SignUpPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController passwordConfirmCont = TextEditingController();

  bool _obscureText = true;
  String? password;
  String? password_confirm;

  var isChecked = false;

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWidget(context,
            showLeadingIcon: false,
            title: 'Kata Sandi',
            roundCornerShape: true,
            appBarHeight: 80),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.height,
                        Text(
                          'Kata Sandi',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        5.height,
                        Text(
                          'Masukan Kata Sandi Anda!',
                        ),
                        10.height,
                        Text(
                          'Kata Sandi',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        10.height,
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
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.5, color: mainColor),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          validator: _passwordValidator,
                        ),
                        10.height,
                        Text(
                          'Konfirmasi Kata Sandi',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        10.height,
                        TextFormField(
                          controller: passwordConfirmCont,
                          onSaved: (newValue) => password_confirm = newValue,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Konfirmasi Kata Sandi',
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
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.5, color: mainColor),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          validator: _passwordValidator,
                        ),
                        20.height,
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Saya telah membaca dan setuju dengan ",
                                style: const TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Syarat',
                                    style: const TextStyle(
                                        color: Color(0xFF3D80DE)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                      },
                                  ),
                                  const TextSpan(
                                    text: " dan ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Ketentuan',
                                    style: const TextStyle(
                                        color: Color(0xFF3D80DE)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                      },
                                  ),
                                  const TextSpan(
                                    text: " dan ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: 'Kebijakan Privasi.',
                                    style: const TextStyle(
                                        color: Color(0xFF3D80DE)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pop(context);
                                      },
                                  ),
                                ],
                              ),
                            ).expand(),
                          ],
                        ),
                        20.height,
                        ElevatedButton(
                          onPressed: () async {},
                          style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll<Color>(
                                    mainColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 48)),
                          ),
                          child: const Text(
                            'Simpan',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: whiteColor),
                          ),
                        ),
                      ],
                    )))));
  }
}
