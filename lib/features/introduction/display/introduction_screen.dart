import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/color_const.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import '../../sign_in/display/views/login_page.dart';

class IntroductionScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const IntroductionScreen());
  }

  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/images/img_introduction.png',
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // body: Column(
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         BlocProvider.of<AuthenticationBloc>(context)
          //             .add(const SaveIntroductionState(true));
          //         Navigator.of(context).pushAndRemoveUntil<void>(
          //           LoginPage.route(),
          //           (route) => false,
          //         );
          //       },
          //       child: Text('Continue'),
          //     )
          //   ],
          // ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 68.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.asset(
                  'assets/images/img_porto_logo.png',
                  width: 142.w,
                  height: 32.11.h,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Membuat Semuanya Jadi Lebih Mudah',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff232323),
                  ),
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: ColorConst.defaultColor,
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      const SaveIntroductionState(true),
                    );
                    Navigator.of(context).pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Ayo Mulai!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 52.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
