import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/colors.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:kms_bpkp_mobile/routes.dart';
import 'package:nb_utils/nb_utils.dart';

class UbahSandiScreen extends StatefulWidget {
  const UbahSandiScreen({super.key});

  @override
  State<UbahSandiScreen> createState() => _UbahSandiScreenState();
}

class _UbahSandiScreenState extends State<UbahSandiScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCont = TextEditingController();
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWidget(context,
            showLeadingIcon: false,
            title: 'Ubah Kata Sandi',
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
                          'Ubah Kata Sandi',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        5.height,
                        Text(
                          'Masukan Email Anda!',
                        ),
                        10.height,
                        TextFormField(
                          controller: emailCont,
                          onSaved: (newValue) => email = newValue,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: "Email",
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.5, color: mainColor),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          //validator: _emailValidator,
                        ),
                        20.height,
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, ubahSandiKonfirmRoute);
                          },
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
