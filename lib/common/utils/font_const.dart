import 'package:flutter/material.dart';

import 'color_const.dart';

class FontConst {
  //BASE
  static const regularFont = TextStyle();
  static const boldFont = TextStyle(fontWeight: FontWeight.bold);

  //REGULAR BLACK
  static final regularDefaultBlack =
      regularFont.copyWith(color: ColorConst.colorBLACK);
  static final regularDefaultBlack12 =
      regularDefaultBlack.copyWith(fontSize: 12);
  static final regularDefaultBlack14 =
      regularDefaultBlack.copyWith(fontSize: 14);
  static final regularDefaultBlack16 =
      regularDefaultBlack.copyWith(fontSize: 16);
      static final regularDefaultBlack18 =
      regularDefaultBlack.copyWith(fontSize: 18);

  //REGULAR WHITE
  static final regularDefaultWhite = regularFont.copyWith(color: Colors.white);
  static final regularDefaulWhite12 =
      regularDefaultWhite.copyWith(fontSize: 12);
  static final regularDefaulWhite14 =
      regularDefaultWhite.copyWith(fontSize: 14);
  static final regularDefaulWhite16 =
      regularDefaultWhite.copyWith(fontSize: 16);
      static final regularDefaulWhite18 =
      regularDefaultWhite.copyWith(fontSize: 18);

  //BOLD BLACK
  static final boldBlack = boldFont.copyWith(color: ColorConst.colorBLACK);
  static final boldBlack12 = boldBlack.copyWith(fontSize: 12);
  static final boldBlack14 = boldBlack.copyWith(fontSize: 14);
  static final boldBlack16 = boldBlack.copyWith(fontSize: 16);
   static final boldBlack18 = boldBlack.copyWith(fontSize: 16);

  //REGULAR GREY
  static final regularDefaultGrey =
      regularFont.copyWith(color: Colors.grey[600]);
  static final regularDefaultGrey12 = regularDefaultGrey.copyWith(fontSize: 12);
  static final regularDefaultGrey14 = regularDefaultGrey.copyWith(fontSize: 14);
}
