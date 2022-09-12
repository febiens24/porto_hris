import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/const.dart';
import '../../../core/injector.dart';
import '../../approval/empty_approval_page.dart';
import '../../approval/error_approval_page.dart';
import '../../widgets/widget_toolbar.dart';
import '../attendance_approval_history/attendance_approval_history_page.dart';
import '../attendance_detail/attendance_detail_page.dart';
import 'bloc/attendance_approval_bloc.dart';

class AttendanceApprovalPage extends StatelessWidget {
  const AttendanceApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceApprovalBloc(
        getAttendanceApprovalList: injector(),
      )..add(LoadAttendanceApprovalList()),
      child: const AttendanceApprovalPageView(),
    );
  }
}

class AttendanceApprovalPageView extends StatefulWidget {
  const AttendanceApprovalPageView({Key? key}) : super(key: key);

  @override
  State<AttendanceApprovalPageView> createState() =>
      _AttendanceApprovalPageViewState();
}

class _AttendanceApprovalPageViewState
    extends State<AttendanceApprovalPageView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool alive = true;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: ColorConst.defaultColor,
      //   centerTitle: true,
      //   title: const Text('Approval'),
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.history_outlined),
      //     ),
      //   ],
      // ),
      body: BlocListener<AttendanceApprovalBloc, AttendanceApprovalState>(
        listener: (context, state) {
          if (state is AttendanceApprovalLoadSuccess) {
            final leaveApprovals = state.attendanceApprovals.result;
            if (leaveApprovals!.isEmpty) {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const EmptyApprovalPage(
                    source: kAttendance,
                  ),
                ),
              );
            }
          } else if (state is AttendanceApprovalLoadFailure) {
            final errMsg = state.errors;
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ErrorApprovalPage(
                  errorMsg: errMsg["result"].toString().toLowerCase(),
                  // errorMsg: "an unknown error occurred",
                ),
              ),
            );
          }
        },
        child: BlocBuilder<AttendanceApprovalBloc, AttendanceApprovalState>(
          builder: (context, state) {
            if (state is AttendanceApprovalLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AttendanceApprovalLoadSuccess) {
              final attendanceApprovals = state.attendanceApprovals.result;
              return SafeArea(
                child: Column(
                  children: [
                    WidgetToolBar(
                      title: 'Attendance',
                      actionButton: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AttendanceApprovalHistoryPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 50,
                    //   child: ListView.builder(
                    //     padding: const EdgeInsets.symmetric(horizontal: 20),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 2,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       switch (index) {
                    //         case 0:
                    //           return Padding(
                    //             padding: const EdgeInsets.only(right: 10),
                    //             child: FilterChip(
                    //               label: Text(
                    //                 'Semua type',
                    //                 style: textTheme.caption,
                    //               ),
                    //               onSelected: (bool value) {
                    //                 print(value);
                    //               },
                    //               side: const BorderSide(
                    //                 color: Color(0xffADADAD),
                    //               ),
                    //               backgroundColor: Colors.white,
                    //             ),
                    //           );
                    //         case 1:
                    //           return FilterChip(
                    //             label: Text(
                    //               'Semua tanggal',
                    //               style: textTheme.caption,
                    //             ),
                    //             onSelected: (bool value) {
                    //               print(value);
                    //             },
                    //             side: const BorderSide(
                    //               color: Color(0xffADADAD),
                    //             ),
                    //             backgroundColor: Colors.white,
                    //           );
                    //         default:
                    //           return const SizedBox.shrink();
                    //       }
                    //     },
                    //   ),
                    // ),
                    Container(
                      width: double.infinity,
                      color: const Color(0xff272B40),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.announcement_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Ada ${attendanceApprovals!.length} permohonan yang harus diproses',
                            style: textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<AttendanceApprovalBloc>(context).add(
                            LoadAttendanceApprovalList(),
                          );
                        },
                        child: ListView.separated(
                          itemCount: attendanceApprovals.length,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 10,
                            color: Color(0xffF1FCFF),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final attendanceApproval =
                                attendanceApprovals[index];
                            if (alive) {
                              return Slidable(
                                key: UniqueKey(),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(
                                    onDismissed: () {
                                      setState(() {
                                        alive = false;
                                      });
                                    },
                                    closeOnCancel: true,
                                    confirmDismiss: () async {
                                      return await showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Are you sure?'),
                                                content: const Text(
                                                    'Are you sure to dismiss?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                    child: const Text('Yes'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: const Text('No'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) ??
                                          false;
                                    },
                                  ),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) => print('asd'),
                                      backgroundColor: const Color(0xFFFF5D5D),
                                      foregroundColor: Colors.white,
                                      icon: Icons.close,
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) => print('asd'),
                                      backgroundColor: const Color(0xFF4E944F),
                                      foregroundColor: Colors.white,
                                      icon: Icons.check,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AttendanceDetailPage(
                                          attendanceId:
                                              attendanceApproval.attendanceId,
                                          source: 'approval',
                                        ),
                                      ),
                                    );
                                  },
                                  isThreeLine: true,
                                  leading: CachedNetworkImage(
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.contain,
                                    imageUrl: attendanceApproval
                                        .attendanceRequesterProfilePicture!,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      backgroundImage: imageProvider,
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        attendanceApproval
                                            .attendanceDocumentNumber,
                                        style: textTheme.bodySmall,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          // Container(
                                          //   padding: const EdgeInsets.symmetric(
                                          //     horizontal: 5,
                                          //     vertical: 4,
                                          //   ),
                                          //   decoration: BoxDecoration(
                                          //     borderRadius: BorderRadius.circular(6),
                                          //     border: Border.all(
                                          //       color: const Color(0xff0B6238),
                                          //     ),
                                          //     color: const Color(0xffD7FFEB),
                                          //   ),
                                          //   child: Text(
                                          //     "Approved",
                                          //     style: textTheme.labelMedium!.copyWith(
                                          //       color: const Color(0xff0B6238),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox.shrink(),
                                          Expanded(
                                            // width: 175,
                                            child: Text(
                                              attendanceApproval
                                                  .attendanceRequesterName!,
                                              style: textTheme.bodyMedium!
                                                  .copyWith(
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox.shrink(),
                                          Expanded(
                                            child: Text(
                                              attendanceApproval
                                                  .attendanceDateTime,
                                              style: textTheme.bodySmall,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            attendanceApproval.attendanceNotes,
                                            style: textTheme.bodySmall,
                                          ),
                                          const Icon(Icons.attachment)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox(
                                height: 4,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
