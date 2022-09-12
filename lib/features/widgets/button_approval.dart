import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonApproval extends StatelessWidget {
  const ButtonApproval({
    Key? key,
    required this.iconPath,
    required this.label,
    required this.counter,
    this.onTap,
  }) : super(key: key);

  final String iconPath;
  final String label;
  final Function()? onTap;
  final int counter;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Badge(
      toAnimate: false,
      // showBadge: false,
      badgeContent: Text(
        '$counter',
        style: textTheme.caption!.copyWith(color: Colors.white),
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 100.w,
          height: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 48.w,
                height: 48.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                label,
                style: textTheme.caption,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
