import 'package:flutter/cupertino.dart';

class Validators {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return "Email không được để trống";
    } else if (!isValidEmail(email)) {
      return "Email không hợp lệ";
    }
    return null; // Không có lỗi
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Mật khẩu không được để trống";
    } else if (!isValidPassword(password)) {
      return "Mật khẩu phải có ít nhất 6 ký tự";
    }
    return null;
  }

  static String? validateFullName(String fullName){
    if(fullName.isEmpty){
      return "FullName không được để trống";
    }
    return null;
  }
}

class FocusHelper {
  static void setupFocusListeners({
    required FocusNode focusNode,
    required VoidCallback onFocusGained,
  }) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        onFocusGained();
      }
    });
  }
}
