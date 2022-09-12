import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hris_project/features/approval/forbidden_approval_page.dart';

import '../../../common/utils/color_const.dart';
import '../../account/display/account_page.dart';
import '../../approval/approval_page.dart';
import '../../report/display/report_page.dart';
import 'home_page.dart';

class Navigation extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const Navigation());
  }

  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentTab = 0;
  DateTime? currentBackPressTime;

  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = const HomePage();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Tekan sekali lagi untuk keluar',
        toastLength: Toast.LENGTH_SHORT,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          padding: const EdgeInsets.all(15).r,
          child: Image.asset(
            'assets/icons/ic_attendance.png',
          ),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                stops: [
                  0.10,
                  0.90,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF405aad),
                  Color(0xFF7293ff),
                ],
              )),
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: 40.w,
                onPressed: () {
                  setState(() {
                    currentScreen = const HomePage();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    currentTab == 0
                        ? Image.asset(
                            'assets/icons/ic_home_active.png',
                            width: 24.w,
                            height: 24.w,
                          )
                        : Image.asset(
                            'assets/icons/ic_home_inactive.png',
                            width: 24.w,
                            height: 24.w,
                          ),
                    Text(
                      'Beranda',
                      // style: TextStyle(
                      //   color: currentTab == 0
                      //       ? ColorConst.defaultColor
                      //       : Colors.grey,
                      //   fontSize: 12.sp,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      style: textTheme.caption!.copyWith(
                        color: currentTab == 0
                            ? ColorConst.defaultColor
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                padding: const EdgeInsets.all(3).r,
                onPressed: () {
                  setState(() {
                    currentScreen = const ForbiddenApprovalPage();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    currentTab == 1
                        ? Image.asset(
                            'assets/icons/ic_approval_active.png',
                            width: 24.w,
                            height: 24.w,
                          )
                        : Image.asset(
                            'assets/icons/ic_approval_inactive.png',
                            width: 24.w,
                            height: 24.w,
                          ),
                    Text(
                      'Persetujuan',
                      style: textTheme.caption!.copyWith(
                        color: currentTab == 1
                            ? ColorConst.defaultColor
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50.w,
              ),
              MaterialButton(
                minWidth: 40.w,
                onPressed: () {
                  setState(() {
                    currentScreen = const ReportPage();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    currentTab == 2
                        ? Image.asset(
                            'assets/icons/ic_report_active.png',
                            width: 24.w,
                            height: 24.h,
                          )
                        : Image.asset(
                            'assets/icons/ic_report_inactive.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                    Text('Laporan',
                        style: textTheme.caption!.copyWith(
                          color: currentTab == 2
                              ? ColorConst.defaultColor
                              : Colors.grey,
                        )),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40.w,
                onPressed: () {
                  setState(() {
                    currentScreen =  AkunPage(bahasa: 'en',);
                    currentTab = 3;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    currentTab == 3
                        ? Image.asset(
                            'assets/icons/ic_account_active.png',
                            width: 24.w,
                            height: 24.h,
                          )
                        : Image.asset(
                            'assets/icons/ic_account_inactive.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                    Text('Akun',
                        style: textTheme.caption!.copyWith(
                          color: currentTab == 3
                              ? ColorConst.defaultColor
                              : Colors.grey,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
