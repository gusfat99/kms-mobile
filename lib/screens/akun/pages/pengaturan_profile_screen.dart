import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/helpers/text_field_widget.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

class PengaturanProfileScreen extends StatefulWidget {
  const PengaturanProfileScreen({super.key});

  @override
  State<PengaturanProfileScreen> createState() =>
      _PengaturanProfileScreenState();
}

class _PengaturanProfileScreenState extends State<PengaturanProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWidget(context,
            showLeadingIcon: false,
            title: 'Pengaturan Profile',
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
                        TextFieldWidget(
                          label: "Nama Lengkap",
                          text: "",
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                        10.height,
                        TextFieldWidget(
                          label: "Nama Panggil",
                          text: "",
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                        10.height,
                        TextFieldWidget(
                          label: "NIP",
                          text: "",
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                        10.height,
                        TextFieldWidget(
                          label: "Unit Kerja",
                          text: "",
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                        10.height,
                        TextFieldWidget(
                          label: "user Level",
                          text: "",
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                        10.height,
                        TextFieldWidget(
                          label: "Alamat Email",
                          text: "",
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                        10.height,
                        TextFieldWidget(
                          label: "Kata Sandi",
                          text: "",
                          readonly: true,
                          onChanged: (value) {
                            //_judul = value;
                          },
                        ),
                      ],
                    )))));
  }
}
