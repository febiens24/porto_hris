import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/injector.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/home/display/home_page.dart';
import 'features/home/display/navigation.dart';
import 'features/introduction/display/introduction_screen.dart';
import 'features/introduction/display/splash_page.dart';
import 'features/sign_in/display/views/login_page.dart';

class HRISApps extends StatelessWidget {
  const HRISApps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        deleteAllData: injector(),
        deleteUser: injector(),
        getInstallationStatus: injector(),
        getIntroductionScreenStatus: injector(),
        getUser: injector(),
        updateInstallationStatus: injector(),
        saveIntroductionScreenStatus: injector(),
        saveUser: injector(),
      )..add(AppStarted()),
      child: const HRISAppsView(),
    );
  }
}

class HRISAppsView extends StatefulWidget {
  const HRISAppsView({Key? key}) : super(key: key);

  @override
  State<HRISAppsView> createState() => _HRISAppsViewState();
}

class _HRISAppsViewState extends State<HRISAppsView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 667),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          theme: ThemeData(
            // textTheme: TextTheme(
            //   headline1: GoogleFonts.libreFranklin(
            //     fontSize: 96.sp,
            //     fontWeight: FontWeight.w300,
            //     letterSpacing: -1.5,
            //   ),
            //   headline2: GoogleFonts.libreFranklin(
            //     fontSize: 60.sp,
            //     fontWeight: FontWeight.w300,
            //     letterSpacing: -0.5,
            //   ),
            //   headline3: GoogleFonts.libreFranklin(
            //     fontSize: 48.sp,
            //     fontWeight: FontWeight.w400,
            //   ),
            //   headline4: GoogleFonts.libreFranklin(
            //     fontSize: 34.sp,
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 0.25,
            //   ),
            //   headline5: GoogleFonts.libreFranklin(
            //     fontSize: 24.sp,
            //     fontWeight: FontWeight.w400,
            //   ),
            //   headline6: GoogleFonts.libreFranklin(
            //     fontSize: 20.sp,
            //     fontWeight: FontWeight.w500,
            //     letterSpacing: 0.15,
            //   ),
            //   subtitle1: GoogleFonts.libreFranklin(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 0.15,
            //   ),
            //   subtitle2: GoogleFonts.libreFranklin(
            //     fontSize: 14.sp,
            //     fontWeight: FontWeight.w500,
            //     letterSpacing: 0.1,
            //   ),
            //   bodyText1: GoogleFonts.libreFranklin(
            //     fontSize: 16.sp,
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 0.5,
            //   ),
            //   bodyText2: GoogleFonts.libreFranklin(
            //     fontSize: 14.sp,
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 0.25,
            //   ),
            //   button: GoogleFonts.libreFranklin(
            //     fontSize: 14.sp,
            //     fontWeight: FontWeight.w500,
            //     letterSpacing: 1.25,
            //   ),
            //   caption: GoogleFonts.libreFranklin(
            //     fontSize: 12.sp,
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 0.4,
            //   ),
            //   overline: GoogleFonts.libreFranklin(
            //     fontSize: 10.sp,
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 1.5,
            //   ),
            // ),
            textTheme: GoogleFonts.libreFranklinTextTheme().copyWith(
              headline1: GoogleFonts.libreFranklin(
                fontSize: 96.sp,
                fontWeight: FontWeight.w300,
                letterSpacing: -1.5,
              ),
              headline2: GoogleFonts.libreFranklin(
                fontSize: 60.sp,
                fontWeight: FontWeight.w300,
                letterSpacing: -0.5,
              ),
              headline3: GoogleFonts.libreFranklin(
                fontSize: 48.sp,
                fontWeight: FontWeight.w400,
              ),
              headline4: GoogleFonts.libreFranklin(
                fontSize: 34.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              headline5: GoogleFonts.libreFranklin(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
              headline6: GoogleFonts.libreFranklin(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
              ),
              subtitle1: GoogleFonts.libreFranklin(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.15,
              ),
              subtitle2: GoogleFonts.libreFranklin(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
              bodyText1: GoogleFonts.libreFranklin(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
              ),
              bodyText2: GoogleFonts.libreFranklin(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
              ),
              button: GoogleFonts.libreFranklin(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.25,
              ),
              caption: GoogleFonts.libreFranklin(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.4,
              ),
              overline: GoogleFonts.libreFranklin(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
              ),
            ),
          ),
          // routes: allRoutes,>
          home: const SplashPage(),
          // home: const TestingPage(),
          builder: EasyLoading.init(
            builder: (context, child) {
              return BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationComplete) {
                    _navigator.pushAndRemoveUntil<void>(
                      Navigation.route(),
                      (route) => false,
                    );
                  } else if (state is AuthenticationUnauthenticated) {
                    if (state.introductionStatus!) {
                      _navigator.pushAndRemoveUntil<void>(
                        LoginPage.route(),
                        (route) => false,
                      );
                    } else {
                      _navigator.pushAndRemoveUntil<void>(
                        IntroductionScreen.route(),
                        (route) => false,
                      );
                    }
                  }
                },
                child: child,
              );
            },
          ),
          // builder: EasyLoading.init(),
          onGenerateRoute: generateRoute,
        );
      },
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  var uri = Uri.parse(settings.name!);
  switch (uri.path) {
    case 'home':
      return MaterialPageRoute(builder: (_) => const HomePageView());
    case 'login':
      return MaterialPageRoute(builder: (_) => const LoginPage());
    default:
      return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}
