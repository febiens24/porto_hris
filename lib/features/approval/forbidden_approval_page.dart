import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForbiddenApprovalPage extends StatelessWidget {
  const ForbiddenApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Approval',
          // style: TextStyle(
          //   color: Colors.black,
          // ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/img_forbidden.png",
              fit: BoxFit.cover,
              // width: 188.w,
              // height: 140.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Nothing to see here!',
              textAlign: TextAlign.center,
              style: textTheme.headline6!.copyWith(
                color: const Color(0xff263668),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0).r,
              child: Text(
                'Sorry, this area is for the chosen only. Go back quickly',
                textAlign: TextAlign.center,
                style: textTheme.subtitle1!.copyWith(
                  color: const Color(0xff33488A),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
