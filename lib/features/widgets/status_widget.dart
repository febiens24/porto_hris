import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    required this.status,
    required this.textTheme,
  }) : super(key: key);

  final String status;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 6,
          ).r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6).r,
            border: Border.all(
              color: status == "approved" || status == "Active"
                  ? const Color(0xff0B6238)
                  : status == "reject" || status == "Inactive"
                      ? const Color(0xffFF0B0B)
                      : const Color(0xffCF8900),
            ),
            color: status == "approved" || status == "Active"
                ? const Color(0xffD7FFEB)
                : status == "reject" || status == "Inactive"
                    ? const Color(0xffFFD7D7)
                    : const Color(0xffFFE0A4),
          ),
          child: Text(
            status,
            style: textTheme.labelMedium!.copyWith(
              color: status == "approved" || status == "Active"
                  ? const Color(0xff0B6238)
                  : status == "reject" || status == "Inactive"
                      ? const Color(0xffFF0B0B)
                      : const Color(0xffCF8900),
            ),
          ),
        ),
        status != "waiting"
            ? const SizedBox.shrink()
            : IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              )
        // PopupMenuButton<String>(
        //   padding: const EdgeInsets.all(2),
        //   // onSelected: handleClick,
        //   itemBuilder: (BuildContext context) {
        //     return {'Cancel'}.map((String choice) {
        //       return PopupMenuItem<String>(
        //         value: choice,
        //         child: Text(choice),
        //       );
        //     }).toList();
        //   },
        // ),
      ],
    );
  }
}
