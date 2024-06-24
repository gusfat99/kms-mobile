import 'dart:convert';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kms_bpkp_mobile/models/api_error_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart' as p;

import 'constant.dart';

Future<Response> postRequest(String endPoint, reqP, String token) async {
  try {
    String url = endPoint;
    String paramJson = json.encode(reqP);
    
    //print("Param : " + paramJson);
    Response response = await post(Uri.parse(url), body: paramJson, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).timeout(const Duration(seconds: 30), onTimeout: () => throw timeOut);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 401) {
      //Token Expired
      throw ("Token Expired");
    } else {
      var res = response.body;
      if (response.body.contains("success")) {
        ErrorModel err = ErrorModel.fromJson(jsonDecode(res));
        throw err.data;
      }
      throw res;
    }
  } catch (e) {
    if (!await isNetworkAvailable()) {
      throw noInternet;
    } else if (e.toString().contains(failedHost)) {
      throw cantConnect;
    } else {
      throw e.toString();
    }
  }
}

Future<Response> getRequest(
    String endPoint, Map<String, String> reqParam, String token) async {
  try {
    String params = Uri(queryParameters: reqParam).query;
    String url = "$endPoint?$params";
    //print(url);
    Response response = await get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    }).timeout(const Duration(seconds: 30), onTimeout: () => throw timeOut);

    if (response.statusCode == 200) {
      //print(response);
      return response;
    } else if (response.statusCode == 401) {
      //Token Expired
      throw ("Token Expired");
    } else {
      var res = response.body;
      if (response.body.contains("success")) {
        ErrorModel err = ErrorModel.fromJson(jsonDecode(res));
        throw err.data;
      }
      throw res;
    }
  } catch (e) {
    if (!await isNetworkAvailable()) {
      throw noInternet;
    } else if (e.toString().contains(failedHost)) {
      throw cantConnect;
    } else {
      throw e.toString();
    }
  }
}

Future<Response> postRequestWithFile(
    String endPoint, Map<String, String> req, File file, String token) async {
  try {
    if (!await isNetworkAvailable()) throw "noInternetMsg";

    String url = endPoint;
    //print(url);
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    };
    if (file != null) {
      final ext = p.extension(file.path);
      print(file.path.replaceAll(ext, ext.toLowerCase()));
      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.replaceAll(".PNG", ".png"),
        ),
      );
    }

    request.headers.addAll(headers);
    request.fields.addAll(req);
    //print("request: " + request.toString());
    StreamedResponse response = await request.send();
    //print("This is response:" + response.toString());

    return http.Response.fromStream(response);
  } catch (e) {
    //print(e);
    if (!await isNetworkAvailable()) {
      throw "noInternetMsg";
    } else if (e.toString().contains("Failed host")) {
      throw "cannot connect to server";
    } else {
      throw e.toString();
    }
  }
}
