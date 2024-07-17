import 'package:flutter/material.dart';

abstract class AppColorsTokens {
  Color get primaryColor;
  Color get secondaryColor;
  Color get accentColor;
  Color get errorColor;
  Color get backgroundColor;
  Color get onPrimaryColor;
  Color get onBackgroundColor;
  Color get onSecondaryColor;
  Color get onErrorColor;
}

class AppColorsLightTokens implements AppColorsTokens {
  @override
  Color get primaryColor => const Color(0xFFAB540D);

  @override
  Color get onPrimaryColor => Colors.white;

  @override
  Color get secondaryColor => Colors.grey.shade800;

  @override
  Color get onSecondaryColor => const Color.fromRGBO(15, 40, 70, 1);

  @override
  Color get accentColor => const Color.fromARGB(255, 253, 255, 132);

  @override
  Color get errorColor => Colors.red.shade400;

  @override
  Color get onErrorColor => Colors.white;

  @override
  Color get backgroundColor => const Color.fromARGB(255, 210, 253, 255);

  @override
  Color get onBackgroundColor => const Color.fromRGBO(15, 40, 70, 1);
}

class AppColorsDarkTokens implements AppColorsTokens {
  @override
  Color get primaryColor => const Color.fromARGB(255, 239, 170, 85);

  @override
  Color get onPrimaryColor => const Color.fromRGBO(15, 40, 70, 1);

  @override
  Color get secondaryColor => const Color(0xFF2F8D85);

  @override
  Color get onSecondaryColor => Colors.white;

  @override
  Color get accentColor => const Color(0xFFFEBE22);

  @override
  Color get errorColor => Colors.red.shade400;

  @override
  Color get onErrorColor => Colors.white;

  @override
  Color get backgroundColor => const Color.fromRGBO(33, 42, 50, 1);

  @override
  Color get onBackgroundColor => Colors.white;
}
