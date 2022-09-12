import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const.dart';
import '../../../core/injector.dart';
import '../attendance_detail/attendance_detail_page.dart';
import 'bloc/attendance_approval_history_bloc.dart';

class AttendanceApprovalHistoryPage extends StatelessWidget {
  const AttendanceApprovalHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceApprovalHistoryBloc(
        getAttendanceApprovalHistoryList: injector(),
      )..add(LoadAttendanceApprovalHistory()),
      child: const AttendanceApprovalHistoryPageView(),
    );
  }
}

class AttendanceApprovalHistoryPageView extends StatefulWidget {
  const AttendanceApprovalHistoryPageView({Key? key}) : super(key: key);

  @override
  State<AttendanceApprovalHistoryPageView> createState() =>
      _AttendanceApprovalHistoryPageViewState();
}

class _AttendanceApprovalHistoryPageViewState
    extends State<AttendanceApprovalHistoryPageView> {
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
          BlocBuilder<AttendanceApprovalHistoryBloc,
              AttendanceApprovalHistoryState>(
            builder: (context, state) {
              if (state is AttendanceApprovalHistoryLoadSuccess) {
                final attendanceDatas = state.attendanceApprovals.result;
                if (attendanceDatas!.isEmpty) {
                  return Expanded(
                    child: Column(
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
                          'Tidak ada data!',
                          textAlign: TextAlign.center,
                          style: textTheme.headline6!.copyWith(
                            color: const Color(0xff263668),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: attendanceDatas.length,
                      // padding: const EdgeInsets.symmetric(vertical: 20),
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 10,
                        color: Color(0xffF1FCFF),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final attendance = attendanceDatas[index];
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendanceDetailPage(
                                attendanceId: attendance.attendanceId,
                              ),
                            ),
                          ),
                          isThreeLine: true,
                          leading: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.contain,
                            imageUrl:
                                attendance.attendanceRequesterProfilePicture!,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundImage: imageProvider,
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
                                        attendance.attendanceDocumentNumber,
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
                                        borderRadius:
                                            BorderRadius.circular(6).r,
                                        border: Border.all(
                                          color: attendance.attendanceStatus ==
                                                  kApprovedStatus
                                              ? const Color(0xff0B6238)
                                              : attendance.attendanceStatus ==
                                                      kRejectedStatus
                                                  ? const Color(0xffFF0B0B)
                                                  : const Color(0xffCF8900),
                                        ),
                                        color: attendance.attendanceStatus ==
                                                kApprovedStatus
                                            ? const Color(0xffD7FFEB)
                                            : attendance.attendanceStatus ==
                                                    kRejectedStatus
                                                ? const Color(0xffFFD7D7)
                                                : const Color(0xffFFE0A4),
                                      ),
                                      child: Text(
                                        attendance.attendanceStatus,
                                        style: textTheme.labelMedium!.copyWith(
                                          color: attendance.attendanceStatus ==
                                                  kApprovedStatus
                                              ? const Color(0xff0B6238)
                                              : attendance.attendanceStatus ==
                                                      kRejectedStatus
                                                  ? const Color(0xffFF0B0B)
                                                  : const Color(0xffCF8900),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Text(
                                  '${attendance.attendanceRequesterName} - ${attendance.attendanceRequesterRole}',
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
                                      attendance.attendanceNotes.isEmpty
                                          ? '-'
                                          : attendance.attendanceNotes,
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
                                attendance.attendanceDateTime,
                                style: textTheme.bodySmall,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              } else if (state is AttendanceApprovalHistoryLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
