import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/const.dart';

class ApproverStatusWidget extends StatelessWidget {
  const ApproverStatusWidget({
    Key? key,
    required this.textTheme,
    required this.status,
    required this.date,
    required this.approverName,
    this.rejectedReason,
  }) : super(key: key);

  final TextTheme textTheme;
  final String? status, date, approverName, rejectedReason;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  approverName!,
                  style: textTheme.bodyMedium,
                ),
                status!.toLowerCase() == kWaitingApprovalStatus.toLowerCase()
                    ? const SizedBox.shrink()
                    : Text(
                        date!,
                        // style: textTheme.overline!.copyWith(
                        //   color: const Color(0xffADADAD),
                        // ),
                        style: textTheme.bodySmall!.copyWith(
                          color: const Color(0xffADADAD),
                        ),
                      )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 6,
              ).r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6).r,
                border: Border.all(
                  color: status == kApprovedStatus
                      ? const Color(0xff0B6238)
                      : status == kRejectedStatus
                          ? const Color(0xffFF0B0B)
                          : const Color(0xffCF8900),
                ),
                color: status == kApprovedStatus
                    ? const Color(0xffD7FFEB)
                    : status == kRejectedStatus
                        ? const Color(0xffFFD7D7)
                        : const Color(0xffFFE0A4),
              ),
              child: Text(
                status!,
                style: textTheme.labelMedium!.copyWith(
                  color: status == kApprovedStatus
                      ? const Color(0xff0B6238)
                      : status == kRejectedStatus
                          ? const Color(0xffFF0B0B)
                          : const Color(0xffCF8900),
                ),
              ),
            ),
            // status!.toLowerCase() == 'rejected'
            //     ? StatusWidget(
            //         textTheme: textTheme,
            //         status: status!,
            //       )
            //     : status!.toLowerCase() == 'approved'
            //         ? StatusWidget(
            //             textTheme: textTheme,
            //             status: status!,
            //           )
            //         : StatusWidget(
            //             textTheme: textTheme,
            //             status: status!,
            //           )
          ],
        ),
        status!.toLowerCase() == kRejectedStatus.toLowerCase()
            ? const SizedBox(
                height: 25,
              )
            : const SizedBox.shrink(),
        status!.toLowerCase() == kRejectedStatus.toLowerCase()
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rejected Reason',
                    style: textTheme.subtitle2,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    rejectedReason!,
                    style: textTheme.bodyText2!.copyWith(
                      color: const Color(0xffADADAD),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )
            : Column(
                children: const [
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                ],
              ),
      ],
    );
  }
}
