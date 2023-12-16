import 'package:fashon_app/core/utils/colors.dart';
import 'package:flutter/material.dart';

abstract class StylesData {
  static const pageIteamDetails =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const pageiteamtitle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w600);

  static const TitleStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const TitleStyleColor =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: kMainColor);

  static const logoStyle =
      TextStyle(fontSize: 45, color: Colors.black, fontWeight: FontWeight.bold);
  static const titleInfo = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static const headerStyleSelect = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white);

  static const headerStyleUnselect = TextStyle(
      fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey);
  static const nameStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  static const emailStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey);
}
