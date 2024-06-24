import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';

class DokumenScreen extends StatefulWidget {
  const DokumenScreen({super.key});

  @override
  State<DokumenScreen> createState() =>
      _DokumenScreenState();
}

class _DokumenScreenState extends State<DokumenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWidget(context,
            showLeadingIcon: false,
            title: 'Dokumen',
            roundCornerShape: true,
            appBarHeight: 80),
        body: SizedBox());
  }
}
