import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUtils {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static Future<String> getVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      return version;
    } catch (ex) {
      return "Unknown";
    }
  }

  static String convertDateTime(DateTime dateTime) {
    String month = "";

    switch (dateTime.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Des";
        break;
      default:
    }
    return '${dateTime.day} $month ${dateTime.year} ${dateTime.hour < 10 ? '0${dateTime.hour}' : '${dateTime.hour}'}: ${dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}'}';
  }

String convertDateTime1(DateTime dateTime) {
  String month = "";

  switch (dateTime.month) {
    case 1:
      month = "Jan";
      break;
    case 2:
      month = "Feb";
      break;
    case 3:
      month = "Mar";
      break;
    case 4:
      month = "Apr";
      break;
    case 5:
      month = "May";
      break;
    case 6:
      month = "Jun";
      break;
    case 7:
      month = "Jul";
      break;
    case 8:
      month = "Aug";
      break;
    case 9:
      month = "Sep";
      break;
    case 10:
      month = "Oct";
      break;
    case 11:
      month = "Nov";
      break;
    case 12:
      month = "Des";
      break;
    default:
  }
  return '${dateTime.day} $month ${dateTime.year}';
}
}
