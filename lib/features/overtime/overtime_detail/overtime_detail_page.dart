import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../common/utils/color_const.dart';
import '../../../core/injector.dart';
import '../../leave/leave_detail/leave_detail_page.dart';
import '../../widgets/approver_status_widget.dart';
import '../../widgets/data_widget.dart';
import '../../widgets/svg_icon_widget.dart';
import 'bloc/overtime_detail_bloc.dart';

class OvertimeDetailPage extends StatelessWidget {
  final int overtimeId;
  final String? source;
  const OvertimeDetailPage({
    Key? key,
    required this.overtimeId,
    this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OvertimeDetailBloc>(
      create: (context) => OvertimeDetailBloc(
        getOvertimeDetail: injector(),
      )..add(LoadOvertimeDetail(overtimeId)),
      child: OvertimeDetailPageView(
        source: source,
      ),
    );
  }
}

class OvertimeDetailPageView extends StatefulWidget {
  final String? source;
  const OvertimeDetailPageView({Key? key, this.source}) : super(key: key);

  @override
  State<OvertimeDetailPageView> createState() => _OvertimeDetailPageViewState();
}

class _OvertimeDetailPageViewState extends State<OvertimeDetailPageView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Overtime Detail',
        ),
        elevation: 0,
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
      ),
      bottomNavigationBar: BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
        builder: (context, state) {
          if (state is OvertimeListLoadSuccess) {
            final data = state.overtimeDetail.result;
            if (data.overtimeStatus != "waiting") {
              return const BottomAppBar();
            } else if (data.overtimeStatus == "waiting" &&
                widget.source != null &&
                widget.source == "approval") {
              return BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: ColorConst.defaultColor,
                        ),
                        onPressed: () {
                          // Respond to button press
                          _onRejectButtonPressed(context, data.overtimeId);
                        },
                        child: const Text("Reject"),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConst.defaultColor,
                        ),
                        onPressed: () {
                          // Respond to button press
                          _onApproveButtonPressed(context, data.overtimeId);
                        },
                        child: const Text('Approve'),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConst.defaultColor,
                        ),
                        onPressed: () {
                          // Respond to button press
                          _onCancelButtonPressed(context, data.overtimeId);
                        },
                        child: const Text('Cancel Request'),
                      )
                    ],
                  ),
                ),
              );
            }
          } else {
            return const ShimmerLoadingData();
          }
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // DataWidget(
                  //   textTheme: textTheme,
                  //   // data: 'OT/2022/00041',
                  //   data: ReadMoreText(
                  //     'OT/2022/00041',
                  //     trimLines: 2,
                  //     colorClickableText: const Color(0xff6792BA),
                  //     trimMode: TrimMode.Line,
                  //     trimCollapsedText: 'Show more',
                  //     trimExpandedText: ' show less',
                  //     style: textTheme.bodySmall!.copyWith(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   iconPath: 'assets/icons/ic_document.svg',
                  //   label: 'Nomor Dokumen',
                  //   status: 'Approved',
                  // ),
                  widget.source == "approval"
                      ? BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                          builder: (context, state) {
                            if (state is OvertimeListLoadSuccess) {
                              final data = state.overtimeDetail.result;
                              // return ListTile(
                              //   leading: CircleAvatar(
                              //     backgroundImage: CachedNetworkImageProvider(
                              //       data.dispensationRequesterProfilePicture,
                              //     ),
                              //   ),
                              //   title: Text(data.dispensationRequesterName),
                              //   subtitle: Text(data.dispensationRequesterRole),
                              // );
                              return Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      data.overtimeProfilePicture,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.overtimeRequesterName,
                                        style: textTheme.subtitle1,
                                      ),
                                      Text(
                                        data.overtimeRequesterRole,
                                        style: textTheme.bodyText1!.copyWith(
                                          color: const Color(0xff9C9C9C),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            } else {
                              return const ShimmerLoadingData();
                            }
                          },
                        )
                      : const SizedBox.shrink(),
                  widget.source == "approval"
                      ? SizedBox(
                          height: 20.h,
                        )
                      : const SizedBox.shrink(),
                  BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                    builder: (context, state) {
                      if (state is OvertimeListLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.overtimeDetail.result.overtimeDocumentNumber,
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_document.svg',
                          label: 'Nomor Dokumen',
                          status: state.overtimeDetail.result.overtimeStatus,
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_document.svg',
                          label: 'Nomor Dokumen',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                    builder: (context, state) {
                      if (state is OvertimeListLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.overtimeDetail.result.overtimeType,
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_types.svg',
                          label: 'Type',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_types.svg',
                          label: 'Type',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // DataWidget(
                  //   textTheme: textTheme,
                  //   // data: '22 April 2021 - 23 April 2021',
                  //   data: ReadMoreText(
                  //     '22 April 2021 - 23 April 2021',
                  //     trimLines: 2,
                  //     colorClickableText: const Color(0xff6792BA),
                  //     trimMode: TrimMode.Line,
                  //     trimCollapsedText: 'Show more',
                  //     trimExpandedText: ' show less',
                  //     style: textTheme.bodySmall!.copyWith(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   iconPath: 'assets/icons/ic_start_date.svg',
                  //   label: 'Start Date',
                  // ),
                  BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                    builder: (context, state) {
                      if (state is OvertimeListLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.overtimeDetail.result.overtimeStartDate,
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_start_date.svg',
                          label: 'Start Date',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_start_date.svg',
                          label: 'Start Date',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // DataWidget(
                  //   textTheme: textTheme,
                  //   // data: '2 Hari',
                  //   data: ReadMoreText(
                  //     '2 Hari',
                  //     trimLines: 2,
                  //     colorClickableText: const Color(0xff6792BA),
                  //     trimMode: TrimMode.Line,
                  //     trimCollapsedText: 'Show more',
                  //     trimExpandedText: ' show less',
                  //     style: textTheme.bodySmall!.copyWith(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   iconPath: 'assets/icons/ic_end_date.svg',
                  //   label: 'End Date',
                  // ),
                  BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                    builder: (context, state) {
                      if (state is OvertimeListLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.overtimeDetail.result.overtimeEndDate,
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_end_date.svg',
                          label: 'End Date',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_end_date.svg',
                          label: 'End Date',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // DataWidget(
                  //   textTheme: textTheme,
                  //   // data: '01:00:00',
                  //   data: ReadMoreText(
                  //     '01:00:00',
                  //     trimLines: 2,
                  //     colorClickableText: const Color(0xff6792BA),
                  //     trimMode: TrimMode.Line,
                  //     trimCollapsedText: 'Show more',
                  //     trimExpandedText: ' show less',
                  //     style: textTheme.bodySmall!.copyWith(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   iconPath: 'assets/icons/ic_duration.svg',
                  //   label: 'Duration',
                  // ),
                  BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                    builder: (context, state) {
                      if (state is OvertimeListLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.overtimeDetail.result.overtimeDuration,
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_duration.svg',
                          label: 'Duration',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_duration.svg',
                          label: 'Duration',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // DataWidget(
                  //   textTheme: textTheme,
                  //   // data: 'LEA/2022/0001',
                  //   data: ReadMoreText(
                  //     'LEA/2022/0001',
                  //     trimLines: 2,
                  //     colorClickableText: const Color(0xff6792BA),
                  //     trimMode: TrimMode.Line,
                  //     trimCollapsedText: 'Show more',
                  //     trimExpandedText: ' show less',
                  //     style: textTheme.bodySmall!.copyWith(
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   iconPath: 'assets/icons/ic_notes.svg',
                  //   label: 'Notes',
                  // ),
                  BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                    builder: (context, state) {
                      if (state is OvertimeListLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.overtimeDetail.result.overtimeNotes,
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_notes.svg',
                          label: 'Notes',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_notes.svg',
                          label: 'Notes',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SvgIcon(
                                path: 'assets/icons/ic_attachment_2.svg',
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
                                    'Attachment',
                                    style: textTheme.subtitle2!.copyWith(
                                      color: const Color(0xffA7A7A7),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  BlocBuilder<OvertimeDetailBloc,
                                      OvertimeDetailState>(
                                    builder: (context, state) {
                                      if (state is OvertimeListLoadSuccess) {
                                        if (state.overtimeDetail.result
                                            .overtimeAttachments.isNotEmpty) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: state.overtimeDetail
                                                .result.overtimeAttachments
                                                .map((i) {
                                              return InkWell(
                                                onTap: () {
                                                  print('asd');
                                                },
                                                child: SizedBox(
                                                  width: 100,
                                                  height: 100,
                                                  child: Column(
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl:
                                                            i.attachmentLink,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          height: 80,
                                                          width: 80,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        i.attachmentName,
                                                        style:
                                                            textTheme.caption,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        } else {
                                          return const Text('-');
                                        }
                                      } else {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color(0xffF1FCFF),
              thickness: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                child: BlocBuilder<OvertimeDetailBloc, OvertimeDetailState>(
                  builder: (context, state) {
                    if (state is OvertimeListLoadSuccess) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SvgIcon(
                                path: 'assets/icons/ic_approver_status.svg',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Approver Status',
                                style: textTheme.subtitle2,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ...state.overtimeDetail.result.overtimeApprovers.map(
                            (e) {
                              return ApproverStatusWidget(
                                textTheme: textTheme,
                                approverName: e.approverName,
                                date: e.approverDate,
                                status: e.approverStatus,
                                rejectedReason: e.rejectedReason,
                              );
                            },
                          ).toList()
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onRejectButtonPressed(BuildContext context, int leaveId) async {
    final rejectReason = await showTextInputDialog(
      context: context,
      textFields: [
        DialogTextField(
          validator: (value) =>
              value!.isEmpty ? 'Alasan tidak boleh kosong!' : null,
        ),
      ],
      title: 'Reject Reason',
      message: "Silahkan tulis alasan anda",
    );
    if (rejectReason != null) {
      // BlocProvider.of<LeaveDetailBloc>(context).add(
      //   RejectLeaveRequest(leaveId, rejectReason.first),
      // );
    }
  }

  void _onApproveButtonPressed(BuildContext context, int leaveId) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Konfirmasi',
      message: 'Are you sure?',
      defaultType: OkCancelAlertDefaultType.cancel,
    );
    if (result.name == "ok") {
      // BlocProvider.of<LeaveDetailBloc>(context).add(
      //   ApproveLeaveRequest(leaveId),
      // );
    }
  }

  void _onCancelButtonPressed(BuildContext context, int leaveId) async {
    final cancelReason = await showTextInputDialog(
      context: context,
      textFields: [
        DialogTextField(
          validator: (value) =>
              value!.isEmpty ? 'Alasan tidak boleh kosong!' : null,
        ),
      ],
      title: 'Cancel Reason',
      message: 'Silahkan tulis alasan anda',
    );

    if (cancelReason != null) {
      // BlocProvider.of<LeaveDetailBloc>(context).add(
      //   PatchLeaveStatus(leaveId, "cancel", cancelReason.first),
      // );
    }
  }
}
