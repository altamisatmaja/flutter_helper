import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:intl/intl.dart';

class FlutterHelper {
  static String onDateTime(String createdAt) {
    DateTime parsedDate = DateTime.parse(createdAt);
    String formattedDate = DateFormat('dd MMMM yyyy, HH:mm').format(parsedDate);
    return formattedDate;
  }

  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(email);
  }

  static String onDefaultAvatar({required String name, required String defaultsTwoCharacter}) {
    if (name.isEmpty) {
      return defaultsTwoCharacter;
    }
    List<String> parts = name.split(' ');

    if (parts.length >= 2) {
      return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    } else if (parts.isNotEmpty && parts[0].length >= 2) {
      return parts[0][0].toUpperCase() + parts[0][1].toUpperCase();
    } else if (parts.isNotEmpty) {
      return parts[0][0].toUpperCase();
    } else if (parts.isEmpty) {
      return defaultsTwoCharacter;
    }
    return defaultsTwoCharacter;
  }

  static onToDouble(dynamic value) {
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }

  static String onRupiahWithoutSymbol(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  static String onRupiahWitSymbol(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  static onSanitizeBankName(String bankName) {
    return bankName.replaceAll(RegExp(r'[^\x00-\x7F*]'), ' ').replaceAll('*', ' ').replaceAll('PT', '').replaceAll('Tbk', '').replaceAll('(', '').replaceAll(')', '').replaceAll(' )', '').replaceAll('**)', '').replaceAll('Ltd', '').replaceAll('TBK', '');
  }

  static bool isPasswordNotMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  static Color onHexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  static bool isPasswordStrong(String password) {
    if (password.length < 8) return false;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return hasUppercase & hasDigits & hasLowercase & hasSpecialCharacters;
  }

  static double onCalculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371;
    double dLat = (lat2 - lat1) * (pi / 180);
    double dLon = (lon2 - lon1) * (pi / 180);
    double a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1 * (pi / 180)) * cos(lat2 * (pi / 180)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  static String onRandomString(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  static Uint8List onBase64ToImage(String base64String) {
    return base64Decode(base64String);
  }

  Function onDebounce(Function func, int milliseconds) {
    Timer? timer;
    return () {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(Duration(milliseconds: milliseconds), () {
        func.call();
      });
    };
  }

  static int onCalculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  static String onEncryptText(String text, int shift) {
    return String.fromCharCodes(text.runes.map((char) => char + shift));
  }

  static double onRoundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static int onGetWeekOfYear(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  static String onGetDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}
