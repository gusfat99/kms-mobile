import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';

// ignore: use_key_in_widget_constructors
class ErrorScreen extends StatefulWidget {
  static String tag = '/ErrorScreen';
  
  final String errMsg;
  ErrorScreen(this.errMsg, {super.key});

  @override
  ErrorScreenState createState() => ErrorScreenState();
}

class ErrorScreenState extends State<ErrorScreen> {
  
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Error'),
      body: errorWidget(
        context,
        'assets/images/error.png',
        'Error',
        widget.errMsg,
        showRetry: false,
        onRetry: () {
          //toasty(context, 'Retrying');
        },
      ),
    );
  }
}
