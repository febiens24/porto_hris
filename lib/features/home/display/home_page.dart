import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/injector.dart';
import '../../leave/leave_page/leave_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../core/const.dart';
import '../../attendance/attendance/attendance_page.dart';
import '../../business_trip/business_trip_page/business_trip_page.dart';
import '../../dispensation/dispensation/dispensation_page.dart';
import '../../notification/display/notification_page.dart';
import '../../overtime/overtime/overtime_page.dart';
import '../../reprimand/reprimand_page/reprimand_page.dart';
import '../../swap_workdate/swap_workdate_page/swap_workdate_page.dart';
import '../domain/entities/employee_attendance_summary_entity.dart';
import '../domain/entities/employee_birthday_entity.dart';
import '../domain/entities/employee_penalty_summary_entity.dart';
import 'blocs/bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeAttendanceBloc(
            getEmployeeAttendanceSummary: injector(),
          )..add(
              LoadEmployeeAttendanceSummary(),
            ),
        ),
        BlocProvider(
          create: (context) => EmployeePenaltySummaryBloc(
            getEmployeePenaltySummary: injector(),
          )..add(
              LoadEmployeePenaltySummary(),
            ),
        ),
        BlocProvider(
          create: (context) => EmployeeBirthdayBloc(
            getEmployeeBirthday: injector(),
          )..add(
              LoadEmployeeBirthday(),
            ),
        ),
      ],
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => const HomePage());
  // }

  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    _requestPermission();
    super.initState();
  }

  void _requestPermission() async {
    await [
      Permission.location,
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            EasyLoading.show(
              status: 'Loading...',
              dismissOnTap: true,
              maskType: EasyLoadingMaskType.black,
            );
          },
          child: ListView(
            padding: const EdgeInsets.only(bottom: 35),
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0).r,
                child: HeaderWidget(textTheme: textTheme),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                    child: const MainMenuWidget(),
                  ),
                ],
              ),
              SizedBox(
                height: 22.h,
              ),
              Divider(
                thickness: 10.h,
                color: const Color(0xffF1FCFF),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                child: BlocBuilder<EmployeeAttendanceBloc,
                    EmployeeAttendanceState>(
                  builder: (_, state) {
                    if (state is EmployeeAttendanceLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is EmployeeAttendanceLoadSuccess) {
                      final EmployeeAttendanceSummaryResultEntity summary =
                          state.attendanceSummary.result;
                      return AttendanceSummaryWidget(
                        attendanceCount: summary.attendanceCount,
                        dispensationCount: summary.dispensationCount,
                        leaveCount: summary.leaveCount,
                        periode: summary.summaryPeriod,
                        sickCount: summary.sickCount,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              const Divider(
                thickness: 10,
                color: Color(0xffF1FCFF),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<EmployeePenaltySummaryBloc,
                    EmployeePenaltySummaryState>(
                  builder: (_, state) {
                    if (state is EmployeePenaltySummaryLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is EmployeePenaltySummaryLoadSuccess) {
                      final EmployeePenaltySummaryResultEntity summary =
                          state.penaltySummary.result;
                      return PenaltySummaryWidget(
                        absentCount: summary.absentCount,
                        forgotCheckoutCount: summary.forgotClockOutCount,
                        forgotCheckinCount: summary.forgotClockInCount,
                        lateCount: summary.lateCount,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              const Divider(
                thickness: 10,
                color: Color(0xffF1FCFF),
              ),
              SizedBox(
                height: 12.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: BlocBuilder<EmployeeBirthdayBloc, EmployeeBirthdayState>(
                  builder: (_, state) {
                    if (state is EmployeeBirthdayLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is EmployeeBirthdayLoadSuccess) {
                      final birthdayDatas = state.employeeBirthday.result;
                      return EmployeeBirthdayWidget(
                        birthdayDatas: birthdayDatas,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmployeeBirthdayWidget extends StatelessWidget {
  const EmployeeBirthdayWidget({
    Key? key,
    required this.birthdayDatas,
  }) : super(key: key);

  final EmployeeBirthdayResultEntity birthdayDatas;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Karyawan yang berulang tahun bulan ${birthdayDatas.summaryPeriod}',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        SizedBox(
          height: 90.h,
          child: ListView.builder(
            itemCount: birthdayDatas.datas.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final birthdayData = birthdayDatas.datas[index];
              return BirthdayCard(
                data: birthdayData,
              );
            },
          ),
        ),
      ],
    );
  }
}

class BirthdayCard extends StatelessWidget {
  const BirthdayCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final EmployeeEntity data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircleAvatar(
            //   radius: 27.5.r,
            //   backgroundImage: const NetworkImage(
            //     "https://spesialis1.orthopaedi.fk.unair.ac.id/wp-content/uploads/2021/02/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg",
            //   ),
            //   backgroundColor: Colors.white,
            // ),
            CachedNetworkImage(
              imageUrl: "https://picsum.photos/200",
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  radius: 27.5.r,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.white,
                );
              },
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.employeeName),
                Text(data.employeeBirthdayDate),
                Text(data.employeeDivision),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PenaltySummaryWidget extends StatelessWidget {
  const PenaltySummaryWidget({
    Key? key,
    required this.absentCount,
    required this.forgotCheckoutCount,
    required this.forgotCheckinCount,
    required this.lateCount,
  }) : super(key: key);

  final int absentCount;
  final int forgotCheckoutCount;
  final int forgotCheckinCount;
  final int lateCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Ringkasan Penalti',
          style: textTheme.subtitle2,
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          'You have 11 penalties in this month',
          style: textTheme.bodyText2!.copyWith(
            color: const Color(0xff767676),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        RingkasanPenaltiWidget(
          icon: 'assets/icons/ic_briefcase.png',
          iconColor: const Color.fromARGB(255, 0, 119, 255),
          title: 'Absent',
          value: absentCount.toString(),
        ),
        RingkasanPenaltiWidget(
          icon: 'assets/icons/ic_briefcase.png',
          iconColor: const Color(0xff2BC999),
          title: 'Lupa Clock-in',
          value: forgotCheckinCount.toString(),
        ),
        RingkasanPenaltiWidget(
          icon: 'assets/icons/ic_briefcase.png',
          iconColor: const Color(0xffFF6B6B),
          title: 'Lupa Clock-out',
          value: forgotCheckoutCount.toString(),
        ),
        RingkasanPenaltiWidget(
          icon: 'assets/icons/ic_briefcase.png',
          iconColor: const Color(0xffCFC352),
          title: 'Terlambat',
          value: lateCount.toString(),
        ),
      ],
    );
  }
}

class AttendanceSummaryWidget extends StatelessWidget {
  const AttendanceSummaryWidget({
    Key? key,
    required this.periode,
    required this.attendanceCount,
    required this.leaveCount,
    required this.sickCount,
    required this.dispensationCount,
  }) : super(key: key);

  final String periode;
  final int attendanceCount;
  final int leaveCount;
  final int sickCount;
  final int dispensationCount;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Kehadiran',
          style: textTheme.subtitle2,
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          'Periode $periode',
          style: textTheme.bodyText2!.copyWith(
            color: const Color(0xff767676),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        SimpleShadow(
          opacity: 0.2, // Default: 0.5
          sigma: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RingkasanKehadiranWidget(
                      title: 'Kehadiran',
                      color: const Color(0xff2BC999),
                      icon: 'assets/icons/ic_briefcase.png',
                      value: attendanceCount.toString(),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    RingkasanKehadiranWidget(
                      title: 'Sakit',
                      color: const Color(0xffFDDB90),
                      icon: 'assets/icons/ic_magnifier.png',
                      value: sickCount.toString(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RingkasanKehadiranWidget(
                      title: 'Izin',
                      color: const Color(0xffFF6B6B),
                      icon: 'assets/icons/ic_notes.png',
                      value: leaveCount.toString(),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    RingkasanKehadiranWidget(
                      title: 'Cuti',
                      color: const Color(0xff34AFFF),
                      icon: 'assets/icons/ic_person_card.png',
                      value: leaveCount.toString(),
                    ),
                  ],
                ),
                // RingkasanKehadiranWidget(
                //   title: 'Kehadiran',
                //   color: Color(0xff2BC999),
                //   icon: 'assets/icons/ic_briefcase.png',
                //   value: attendanceCount.toString(),
                // ),
                // RingkasanKehadiranWidget(
                //   title: 'Leave',
                //   color: Color(0xffFF6B6B),
                //   icon: 'assets/icons/ic_notes.png',
                //   value: leaveCount.toString(),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.2, // Default: 0.5
      sigma: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuWidget(
                    image: 'assets/icons/ic_kehadiran.png',
                    title: 'Kehadiran',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AttendancePage(),
                        ),
                      );
                    },
                  ),
                  MenuWidget(
                    image: 'assets/icons/ic_leave.png',
                    title: 'Leave',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LeavePage(),
                        ),
                      );
                    },
                  ),
                  MenuWidget(
                    image: 'assets/icons/ic_izin.png',
                    title: 'Dispensasi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DispensationPage(),
                        ),
                      );
                    },
                  ),
                  MenuWidget(
                    image: 'assets/icons/ic_lembur.png',
                    title: 'Lembur',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OvertimePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuWidget(
                    image: 'assets/icons/ic_perjalanan_bisnis.png',
                    title: 'Perjalanan Bisnis',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BusinessTripPage(),
                        ),
                      );
                    },
                  ),
                  MenuWidget(
                    image: 'assets/icons/ic_teguran.png',
                    title: 'Reprimand',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReprimandListPage(),
                        ),
                      );
                    },
                  ),
                  const MenuWidget(
                    image: 'assets/icons/ic_karyawan.png',
                    title: 'Karyawan',
                  ),
                  MenuWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SwapWorkdateListPage(),
                        ),
                      );
                    },
                    image: 'assets/icons/ic_tukar_hari.png',
                    title: 'Tukar Hari',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22.0.r,
              backgroundImage: const NetworkImage(
                imgUrl,
              ),
              backgroundColor: Colors.white,
            ),
            SizedBox(
              width: 18.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User Testing', style: textTheme.headline6),
                Text(
                  'IT Department',
                  style: textTheme.subtitle1,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              tooltip: 'Notification',
              color: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  ),
                );
              },
              icon: Badge(
                toAnimate: false,
                badgeContent: Text(
                  '3',
                  style: textTheme.caption!.copyWith(
                    color: Colors.white,
                  ),
                ),
                child: const Icon(Icons.notifications),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RingkasanPenaltiWidget extends StatelessWidget {
  const RingkasanPenaltiWidget({
    Key? key,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final Color iconColor;
  final String title;
  final String value;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () {
        print('listtile');
      },
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0).r,
      leading: Container(
        padding: const EdgeInsets.all(5).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5.r,
          ),
          color: iconColor,
        ),
        child: Image.asset(
          icon,
          height: 15.h,
          width: 15.h,
        ),
      ),
      title: Text(
        title,
        style: textTheme.subtitle2,
      ),
      subtitle: Text(
        value,
        style: textTheme.caption,
      ),
      trailing: Text(
        'Lihat detail',
        style: textTheme.overline,
      ),
    );
  }
}

class RingkasanKehadiranWidget extends StatelessWidget {
  const RingkasanKehadiranWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.value,
  }) : super(key: key);

  final String title;
  final String icon;
  final Color color;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(4).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                5.r,
              ),
              color: color,
            ),
            child: Image.asset(
              icon,
              height: 15.w,
              width: 15.w,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.subtitle2),
              Text(
                value,
                style: textTheme.caption,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function()? onTap;

  const MenuWidget({
    Key? key,
    required this.image,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color(0xffDADAE3),
        onTap: onTap,
        child: SizedBox(
          width: 60.w,
          height: 60.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 32.w,
                height: 32.w,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
