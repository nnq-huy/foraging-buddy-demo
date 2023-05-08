import 'package:flutter/material.dart';
import 'package:foraging_buddy/extensions/string/as_html_color_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.htmlColorToColor();
  static final facebookColor = '#3b5998'.htmlColorToColor();

  static const green = Color(0xFF395144);
  static const lightGreen = Color(0XFF4E6C50);
  static const brown = Color(0XFFAA8B56);
  static const lightBrown = Color.fromARGB(255, 193, 162, 108);

  static const lightYellow = Color(0xFFF0EBCE);

  static const red = Color(0xFFD96666);
  static const lightRed = Color(0xFFF2CECE);
  static const lightGrey = Color(0xFFDDDDDD);

  static const hunterGreen = Color(0xFF386641);
  static const mayGreen = Color(0xFF6a994e);
  static const androidGreen = Color(0xFFa7c957);
  static const eggshell = Color(0xFFf2e8cf);
  static const bitterSweetShimmer = Color(0xFFbc4749);

  static const appBgColor = hunterGreen;

  const AppColors._();
}

class AppTextStyles {
  static const appMainFont = 'Merriweather';
  static const appButtonFont = 'Monserrat';
  static const appDisplayFont = 'Monserrat';

  static const appTitle = TextStyle(
    fontFamily: appDisplayFont,
    fontSize: 36.0,
  );

  static const analyzing = TextStyle(
      fontFamily: appMainFont,
      fontSize: 25.0,
      color: AppColors.eggshell,
      decoration: TextDecoration.none);

  static const result = TextStyle(
      fontFamily: appDisplayFont,
      fontSize: 35.0,
      color: AppColors.brown,
      decoration: TextDecoration.none);

  static const resultRating = TextStyle(
      fontFamily: appMainFont, fontSize: 18.0, decoration: TextDecoration.none);

  static const map = TextStyle(
    fontFamily: appMainFont,
    fontSize: 14.0,
  );
  static const mapSmall = TextStyle(
    fontFamily: appMainFont,
    fontSize: 12.0,
  );

  static const mapBold = TextStyle(
    fontFamily: appMainFont,
    fontWeight: FontWeight.bold,
    fontSize: 14.0,
  );
  static const listSmall = TextStyle(
      fontFamily: appMainFont,
      fontStyle: FontStyle.italic,
      fontSize: 12.0,
      color: Colors.grey,
      decoration: TextDecoration.none);

  static const mushroomBold = TextStyle(
      fontFamily: appDisplayFont,
      fontWeight: FontWeight.bold,
      fontSize: 18.0,
      decoration: TextDecoration.none);
  static const identifierButton = TextStyle(
    fontFamily: AppTextStyles.appButtonFont,
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.lightYellow,
  );

  const AppTextStyles._();
}
