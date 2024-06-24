import 'package:flutter/material.dart';
import 'package:kms_bpkp_mobile/helpers/widgets.dart';

// ignore: use_key_in_widget_constructors
class NoInternetScreen extends StatefulWidget {
  static String tag = '/NoInternetScreen';

  @override
  NoInternetScreenState createState() => NoInternetScreenState();
}

class NoInternetScreenState extends State<NoInternetScreen> {
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
      appBar: appBar(context, 'No Internet'),
      body: errorWidget(
        context,
        'assets/images/noInternet.jpg',
        'No Internet',
        'There is something wrong with the proxy server or the address is incorrect',
        showRetry: true,
        onRetry: () {
          //toasty(context, 'Retrying');
        },
      ),
    );
  }
}
