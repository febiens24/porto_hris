import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    Key? key,
    required this.path,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  final String path;
  final double? width, height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      color: color,
    );
  }
}
