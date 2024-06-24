import 'package:intl/intl.dart';

String convertDateTime(DateTime dateTime) {
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
  return month + ' ${dateTime.day}, ${dateTime.hour}, ${dateTime.minute}';
}

String convertDateTime2(DateTime dateTime) {
  String month = "";

  switch (dateTime.month) {
    case 1:
      month = "Januari";
      break;
    case 2:
      month = "Februari";
      break;
    case 3:
      month = "Maret";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "Mei";
      break;
    case 6:
      month = "Juni";
      break;
    case 7:
      month = "Juli";
      break;
    case 8:
      month = "Agustus";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "Oktober";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "Desember";
      break;
    default:
  }
  return '${dateTime.day} ' + month + ' ${dateTime.year}';
}

String convertDateTime3(DateTime dateTime) {
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
  return '${dateTime.day} ' +
      month +
      ' ${dateTime.year}' +
      ' ${dateTime.hour < 10 ? '0${dateTime.hour}' : '${dateTime.hour}'}' +
      ':' +
      ' ${dateTime.minute < 10 ? '0${dateTime.minute}' : '${dateTime.minute}'}';
}

String convertDateTime4(DateTime dateTime) {
  String day = "";
  switch (dateTime.weekday) {
    case 1:
      day = "Senin";
      break;
    case 2:
      day = "Selasa";
      break;
    case 3:
      day = "Rabu";
      break;
    case 4:
      day = "Kamis";
      break;
    case 5:
      day = "Jumat";
      break;
    case 6:
      day = "Sabtu";
      break;
    case 7:
      day = "Minggu";
      break;

    default:
  }
  String month = "";
  switch (dateTime.month) {
    case 1:
      month = "Januari";
      break;
    case 2:
      month = "Februari";
      break;
    case 3:
      month = "Maret";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "Mei";
      break;
    case 6:
      month = "Juni";
      break;
    case 7:
      month = "Juli";
      break;
    case 8:
      month = "Agustus";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "Oktober";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "Desember";
      break;
    default:
  }
  return day + ',${dateTime.day} ' + month + ' ${dateTime.year}';
}

String convertDateTime5(DateTime dateTime) {
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
  return '${dateTime.day} ' + month + ' ${dateTime.year}';
}

String convertDateTimeToDay(String tgl) {
  DateTime dateTime = DateTime.parse(tgl);
  String day = "";
  switch (dateTime.weekday) {
    case 1:
      day = "Sen";
      break;
    case 2:
      day = "Sel";
      break;
    case 3:
      day = "Rab";
      break;
    case 4:
      day = "Kam";
      break;
    case 5:
      day = "Jum";
      break;
    case 6:
      day = "Sab";
      break;
    case 7:
      day = "Min";
      break;

    default:
  }
  return day;
}

String convertDateTimeToTime(String tgl) {
  DateTime dateTime = DateTime.parse(tgl);
  DateFormat dateFormat = DateFormat("HH:mm:ss");
  return dateFormat.format(dateTime);
}

String convertDateTimeToDate(String tgl) {
  DateTime dateTime = DateTime.parse(tgl);
  String day = dateTime.day.toString();
  return '${day.length < 2 ? '0${day}' : '${day}'}';
}

String convertDateInfo(String tgl) {
  DateTime dateTime = DateTime.parse(tgl);
  String day = "";
  switch (dateTime.weekday) {
    case 1:
      day = "Senin";
      break;
    case 2:
      day = "Selasa";
      break;
    case 3:
      day = "Rabu";
      break;
    case 4:
      day = "Kamis";
      break;
    case 5:
      day = "Jumat";
      break;
    case 6:
      day = "Sabtu";
      break;
    case 7:
      day = "Minggu";
      break;

    default:
  }
  String month = "";
  switch (dateTime.month) {
    case 1:
      month = "Januari";
      break;
    case 2:
      month = "Februari";
      break;
    case 3:
      month = "Maret";
      break;
    case 4:
      month = "April";
      break;
    case 5:
      month = "Mei";
      break;
    case 6:
      month = "Juni";
      break;
    case 7:
      month = "Juli";
      break;
    case 8:
      month = "Agustus";
      break;
    case 9:
      month = "September";
      break;
    case 10:
      month = "Oktober";
      break;
    case 11:
      month = "November";
      break;
    case 12:
      month = "Desember";
      break;
    default:
  }
  return day + ',${dateTime.day} ' + month + ' ${dateTime.year}';
}
