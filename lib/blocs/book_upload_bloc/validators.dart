import 'dart:io';

class Validators {
  static bool isNameValid(String name) {
    return name.length > 0 && name.length < 64;
  }

  static bool isFileValid(File file) {
    return file != null;
  }
}