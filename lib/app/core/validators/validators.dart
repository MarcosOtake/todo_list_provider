import 'package:flutter/cupertino.dart';

class Validators {
  Validators._();

  static FormFieldValidator<String> compare(
      TextEditingController? controller, String message) {
    return (value) {
      final valueCompare = controller?.text ?? '';
      if (value == null || value != valueCompare) {
        return message;
      }
      return null;
    };
  }
}
