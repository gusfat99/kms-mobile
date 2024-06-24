import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import 'constant.dart';

Future handleResponse(http.Response response) async {
  if (response.statusCode.isSuccessful()) {
    return jsonDecode(response.body);
  } else {
    if (response.body.isJson()) {
      throw jsonDecode(response.body);
    } else {
      if (!await isNetworkAvailable()) {
        throw noInternet;
      } else {
        throw tryAgain + response.body;
      }
    }
  }
}
