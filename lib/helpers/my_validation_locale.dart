import 'package:form_validator/form_validator.dart';

class MyValidationLocale extends FormValidatorLocale {
  @override
  String name() => "custom";

  @override
  String required() => "Wajib diisi";

  @override
  String email(String v) {
    // TODO: implement email
    return v;
    return v;
  }

  @override
  String ip(String v) {
    // TODO: implement ip
    return v;
  }

  @override
  String ipv6(String v) {
    // TODO: implement ipv6
    return v;
  }

  @override
  String maxLength(String v, int n) {
    // TODO: implement maxLength
    return v;
  }

  @override
  String minLength(String v, int n) {
    // TODO: implement minLength
    return v;
  }

  @override
  String phoneNumber(String v) {
    // TODO: implement phoneNumber
    return v;
  }

  @override
  String url(String v) {
    // TODO: implement url
    return v;
  }
}
