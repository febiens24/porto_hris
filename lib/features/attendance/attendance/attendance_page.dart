import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../common/utils/color_const.dart';
import '../../../core/injector.dart';
import '../../clock_in_out/display/clock_in_out_page.dart';
import '../attendance_detail/attendance_detail_page.dart';
import 'bloc/attendance_list_bloc.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceListBloc(
        getAttendanceList: injector(),
      )..add(const LoadAttendanceList()),
      child: const AttendancePageView(),
    );
  }
}

class AttendancePageView extends StatefulWidget {
  const AttendancePageView({Key? key}) : super(key: key);

  @override
  State<AttendancePageView> createState() => _AttendancePageViewState();
}

class _AttendancePageViewState extends State<AttendancePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kehadiran'),
        backgroundColor: ColorConst.defaultColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 210.h,
            color: ColorConst.defaultColor,
            padding: const EdgeInsets.all(20).r,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5).r,
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Hari Senin',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '09:30 - 17:30',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorConst.defaultColor,
                    ),
                  ),
                  const DottedLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 140.w,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: ColorConst.defaultColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ClockInOutPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Clock In',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 140.w,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: ColorConst.defaultColor,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Clock Out',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Material(
                    color: Color(0xff35447B),
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      indicatorWeight: 5,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Color(0xff1F2027),
                      tabs: [
                        Tab(text: 'Kehadiran'),
                        Tab(text: 'Request'),
                        Tab(text: 'History'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        BlocBuilder<AttendanceListBloc, AttendanceListState>(
                          builder: (context, state) {
                            if (state is AttendanceListLoadInProgress) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is AttendanceListLoadSuccess) {
                              final attendanceList =
                                  state.attendanceList.result;
                              return RefreshIndicator(
                                onRefresh: () async {
                                  return Future<void>.delayed(
                                      const Duration(seconds: 3));
                                },
                                child: ListView.builder(
                                  itemCount: attendanceList!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final attendanceListData =
                                        attendanceList[index];
                                    final parsedDate = DateTime.parse(
                                        attendanceListData.attendanceDateTime);
                                    final date = DateFormat('d MMM yyyy')
                                        .format(parsedDate);
                                    final time = DateFormat('HH:mm:ss')
                                        .format(parsedDate);

                                    return ListTile(
                                      onTap: () {
                                        // print(index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AttendanceDetailPage(
                                              attendanceId: attendanceListData
                                                  .attendanceId,
                                            ),
                                          ),
                                        );
                                      },
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            time,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            date,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                        attendanceListData.attendanceMode,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      dense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 5,
                                      ).r,
                                      title: Text(
                                        attendanceListData.attendanceType,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      tileColor: index.isOdd
                                          ? const Color(0xffD6DBE9)
                                          : Colors.white,
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Error',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Center(
                          child: Text(
                            'Display Tab 2',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Display Tab 3',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
