import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/injector.dart';
import '../attendance/attendance_approval_page/attendance_approval_page.dart';
import '../business_trip/business_trip_approval/business_trip_approval_page.dart';
import '../dispensation/dispensation_approval/dispensation_approval_page.dart';
import '../leave/leave_approval/leave_approval_page.dart';
import '../overtime/overtime_approval/overtime_approval_page.dart';
import '../reprimand/reprimand_approval_page/reprimand_approval_page.dart';
import '../swap_workdate/swap_workdate_approval_page/swap_workdate_approval_page.dart';
import '../widgets/button_approval.dart';
import 'bloc/approvals_bloc.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApprovalsBloc(
        getApprovalsCount: injector(),
      )..add(GetApprovalsCount()),
      child: const ApprovalPageView(),
    );
  }
}

class ApprovalPageView extends StatelessWidget {
  const ApprovalPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: RefreshIndicator(
        onRefresh: () async {
          // return Future<void>.delayed(const Duration(seconds: 3));
          BlocProvider.of<ApprovalsBloc>(context).add(GetApprovalsCount());
        },
        child: ListView(
          children: [
            Image.asset(
              'assets/images/img_approval.png',
              fit: BoxFit.cover,
            ),
            BlocBuilder<ApprovalsBloc, ApprovalsState>(
              builder: (context, state) {
                if (state is ApprovalsLoadSuccess) {
                  final data = state.approvalsCount.result;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonApproval(
                            iconPath: 'assets/icons/ic_approval_attendance.png',
                            label: 'Attendance',
                            counter: data.attendanceCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendanceApprovalPage(),
                                ),
                              );
                            },
                          ),
                          ButtonApproval(
                            iconPath: 'assets/icons/ic_approval_leave.png',
                            label: 'Leave',
                            counter: data.leaveCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LeaveApprovalPage(),
                                ),
                              );
                            },
                          ),
                          ButtonApproval(
                            iconPath: 'assets/icons/ic_approval_overtime.png',
                            label: 'Overtime',
                            counter: data.overtimeCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OvertimeApprovalPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonApproval(
                            iconPath:
                                'assets/icons/ic_approval_dispensation.png',
                            label: 'Dispensation',
                            counter: data.dispensationCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DispensationApprovalPage(),
                                ),
                              );
                            },
                          ),
                          ButtonApproval(
                            iconPath:
                                'assets/icons/ic_approval_business_trip.png',
                            label: 'Business trip',
                            counter: data.businessTripCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BusinessTripApprovalPage(),
                                ),
                              );
                            },
                          ),
                          ButtonApproval(
                            iconPath:
                                'assets/icons/ic_approval_swap_workday.png',
                            label: 'Swap workday',
                            counter: data.swapWorkdateCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SwapWorkdateApprovalPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonApproval(
                            iconPath: 'assets/icons/ic_approval_reprimand.png',
                            label: 'Reprimand',
                            counter: data.reprimandCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ReprimandApprovalPage(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 100.w,
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 100.w,
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is ApprovalsLoadInProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text('Error, silahkan refresh'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
