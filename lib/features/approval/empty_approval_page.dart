import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../dispensation/dispensation_approval_history/dispensation_approval_history_page.dart';
import '../leave/leave_approval_history/leave_approval_history_page.dart';
import '../overtime/overtime_approval_history/overtime_approval_history_page.dart';
import '../reprimand/reprimand_approval_history/reprimand_approval_history_page.dart';
import '../swap_workdate/swap_workdate_approval_history/swap_workdate_approval_history_page.dart';

import '../../common/utils/color_const.dart';
import '../../core/const.dart';
import '../attendance/attendance_approval_history/attendance_approval_history_page.dart';
import '../business_trip/business_trip_approval_history/business_trip_approval_history_page.dart';

class EmptyApprovalPage extends StatelessWidget {
  final String source;
  const EmptyApprovalPage({Key? key, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
        title: const Text('Approval'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/img_done.png",
              fit: BoxFit.cover,
              width: 188.w,
              height: 140.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Pekerjaan kamu sudah beres!',
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
                'Klik tombol di bawah untuk melihat riwayat persetujuan',
                textAlign: TextAlign.center,
                style: textTheme.subtitle1!.copyWith(
                  color: const Color(0xff33488A),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ColorConst.defaultColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                ),
                onPressed: () {
                  _onBtnHistoryPressed(context, source);
                },
                child: Text(
                  'See approval history'.toUpperCase(),
                  style: textTheme.button!.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onBtnHistoryPressed(BuildContext context, String source) {
    switch (source) {
      case kAttendance:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AttendanceApprovalHistoryPage(),
          ),
        );
        break;
      case kLeave:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LeaveApprovalHistoryPage(),
          ),
        );
        break;
      case kBusinessTrip:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BusinessTripApprovalHistoryPage(),
          ),
        );
        break;
      case kSwapWorkdate:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SwapWorkdateApprovalHistoryPage(),
          ),
        );
        break;
      case kDispensation:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DispensationApprovalHistoryPage(),
          ),
        );
        break;
      case kReprimand:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ReprimandApprovalHistoryPage(),
          ),
        );
        break;
      case kOvertime:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OvertimeApprovalHistoryPage(),
          ),
        );
        break;
      default:
    }
  }
}
