import 'package:flutter/material.dart';

import '../../../common/utils/color_const.dart';

class AccountWebView extends StatelessWidget {
  const AccountWebView({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
        centerTitle: true,
        backgroundColor: ColorConst.defaultColor,
        elevation: 0,
      ),
      body: Center(child: Text(title)),
    );
  }
}
