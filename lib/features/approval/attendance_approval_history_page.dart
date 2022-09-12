import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceApprovalHistoryPage extends StatefulWidget {
  const AttendanceApprovalHistoryPage({Key? key}) : super(key: key);

  @override
  State<AttendanceApprovalHistoryPage> createState() =>
      _AttendanceApprovalHistoryPageState();
}

class _AttendanceApprovalHistoryPageState
    extends State<AttendanceApprovalHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0).r,
            child: Container(
              width: double.infinity,
              height: 32.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8).r,
                border: Border.all(
                  color: const Color(0xffADADAD),
                ),
              ),
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffADADAD),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5).r,
            width: double.infinity,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                FilterChip(
                  label: Text(
                    'Semua status',
                    style: textTheme.caption,
                  ),
                  onSelected: (bool value) {
                    print(value);
                  },
                  side: const BorderSide(
                    color: Color(0xffADADAD),
                  ),
                  backgroundColor: Colors.white,
                ),
                FilterChip(
                  label: Text(
                    'Semua tanggal',
                    style: textTheme.caption,
                  ),
                  onSelected: (bool value) {
                    print(value);
                  },
                  side: const BorderSide(
                    color: Color(0xffADADAD),
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 9,
              // padding: const EdgeInsets.symmetric(vertical: 20),
              separatorBuilder: (context, index) => const Divider(
                thickness: 10,
                color: Color(0xffF1FCFF),
              ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () => print('ok'),
                  isThreeLine: true,
                  leading: CircleAvatar(
                    backgroundColor: Color(
                            (math.Random().nextDouble() * index * 0xFFFFFF)
                                .toInt())
                        .withOpacity(1.0),
                    child: const Text(
                      'UT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'ATTND/2022/0001',
                                style: textTheme.bodySmall,
                              ),
                            ),
                            const SizedBox.shrink(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 4,
                              ).r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6).r,
                                border: Border.all(
                                  color: const Color(0xff0B6238),
                                ),
                                color: const Color(0xffD7FFEB),
                              ),
                              child: Text(
                                "Approved",
                                style: textTheme.labelMedium!.copyWith(
                                  color: const Color(0xff0B6238),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'Nama Usernya Panjang Sekali - Mobile Dev',
                          style: textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                      ],
                    ),
                    width: 250.w,
                  ),
                  // trailing: Text(
                  //   '09.45',
                  //   style: textTheme.bodySmall,
                  // ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox.shrink(),
                          Expanded(
                            child: Text(
                              'Ini notes yang panjang banget, lorem ipsum sit amet et dolor',
                              style: textTheme.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        '02 June 2022',
                        style: textTheme.bodySmall,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
