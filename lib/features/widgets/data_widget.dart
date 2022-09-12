import 'package:flutter/material.dart';

import 'status_widget.dart';
import 'svg_icon_widget.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    Key? key,
    required this.textTheme,
    required this.iconPath,
    // this.withBadge = false,
    required this.label,
    required this.data,
    this.status,
  }) : super(key: key);

  final TextTheme textTheme;
  final String iconPath;
  // final bool withBadge;
  final String label;
  final Widget data;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgIcon(
                  path: iconPath,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: textTheme.bodyMedium!.copyWith(
                        color: const Color(0xffA7A7A7),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    SizedBox(
                      width: status != null
                          ? MediaQuery.of(context).size.width / 2.25
                          : MediaQuery.of(context).size.width / 1.25,
                      child: data,
                      // child: ReadMoreText(
                      //   data,
                      //   trimLines: 2,
                      //   colorClickableText: const Color(0xff6792BA),
                      //   trimMode: TrimMode.Line,
                      //   trimCollapsedText: 'Show more',
                      //   trimExpandedText: ' show less',
                      //   style: textTheme.bodySmall!.copyWith(
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ],
            ),
            status != null
                ? StatusWidget(
                    textTheme: textTheme,
                    status: status!,
                  )
                : const SizedBox.shrink(),
          ],
        ),
        const Divider(
          color: Color(0xffDADADA),
        ),
      ],
    );
  }
}
