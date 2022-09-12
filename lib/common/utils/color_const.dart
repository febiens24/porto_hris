import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ColorConst {
  static final HexColor badgeColor = HexColor("#CCC5B9");
  static final HexColor defaultColor = HexColor("#405aad");
  static final HexColor whiteLilcac = HexColor("#000002");
  static final HexColor list = HexColor("#666666");
  static final HexColor cardColor = HexColor("#e5e5e5");
  static final HexColor appBar = HexColor("#39519b");
  static final HexColor tulisanAbu = HexColor("#797979");
  static final HexColor defaultColor5 = HexColor("#0DE81667");
  static final HexColor buttonSupport = HexColor("#454545");
  static final HexColor colorRed = HexColor("#F93F3E");
  static final HexColor colorRED2 = HexColor("#D05045");
  static final HexColor colorGREEN = HexColor("#2EC492");
  static final HexColor colorGREEN2 = HexColor("#8CC153");
  static final HexColor colorORANGE = HexColor("#EB8D2F");
  static final HexColor colorWHITE = HexColor("#FFFFFF");
  static final HexColor colorWHITE_50 = HexColor("#80FFFFFF");
  static final HexColor colorWHITE_70 = HexColor("#B3FFFFFF");
  static final HexColor colorBLACK = HexColor("#000000");
  static final HexColor colorBLACK2 = HexColor("#333333");
  static final HexColor colorBLACK_30 = HexColor("#4D000000");
  static final HexColor colorGRAY1 = HexColor("#999999");
  static final HexColor colorGRAY1_50 = HexColor("#80999999");
  static final HexColor colorGRAY1_70 = HexColor("#B3999999");
  static final HexColor colorGRAY2 = HexColor("#F8F8F8");
  static final HexColor colorGRAY3 = HexColor("#F4F4F4");
  static final HexColor colorGRAY4 = HexColor("#666666");
  static final HexColor colorGRAY4_40 = HexColor("#66666666");
  static final HexColor colorGRAY5 = HexColor("#C1C1C1");
  static final HexColor colorGRAY6 = HexColor("#707070");
  static final HexColor colorGRAY7 = HexColor("#DDDDDD");
  static final HexColor colorGRAY8 = HexColor("#EEEEEE");
  static final HexColor colorGRAY60 = HexColor("#999999");
  static final HexColor colorGRAY10 = HexColor("#333333");
  static final HexColor colorItemBg = HexColor("#F3F6F8");
  static final HexColor colorBLUE = HexColor("#2f9fd4");
  static final HexColor colorDIVIDER = HexColor("#33000000");
  static final HexColor colorTRANS = HexColor("00000000");
  static final HexColor colorDefaultBorder = HexColor("#E5E5E5");
  static final HexColor buttonColor = HexColor("#FF405aad");
  static final HexColor silverList = HexColor("#E5E5E5");
  static final HexColor gradientColor1 = HexColor("#324789");
  static final HexColor gradientColor2 = HexColor("#405aad");
  static final HexColor gradientColor3 = HexColor("#0b9ebb");
  static final HexColor ghostWhite = HexColor("#F8F8F8");
  static final HexColor whiteSmoke = HexColor("#F5F5F5");
  static final HexColor colorGRAY9 = HexColor("#444444");
  static final HexColor russianViolet = HexColor("#320E3B");
  static final HexColor chinaPink = HexColor("#E56399");
  static final HexColor cornFlowerBlue = HexColor("#7F96FF");
  static final HexColor lightBlue = HexColor("#A6CFD5");
  static final HexColor lightCyan = HexColor("#DBFCFF");
  static final HexColor statusProses = HexColor("#f48c00");
  static final HexColor statusDone = HexColor("#0f9d58");
  static final HexColor statusReady = HexColor("#0f9d58");
  static final HexColor statusPaid = HexColor("#0f9d58");
  static final HexColor approvedStatusIcon = HexColor("#27AB5C");
  static final HexColor approvedStatusChip = HexColor("#0F9D58");
  static final HexColor awaitingStatusIcon = HexColor("#FFA800");
  static final HexColor awaitingStatusChip = HexColor("#DFA309");
  static final HexColor rejectedStatusIcon = HexColor("#F44336");
  static final HexColor rejectedStatusChip = HexColor("#F40303");
  static final HexColor anotherStatus = HexColor("#FFC107");
  static const MaterialColor statusBar = MaterialColor(0xFF2E3147, {});
}
