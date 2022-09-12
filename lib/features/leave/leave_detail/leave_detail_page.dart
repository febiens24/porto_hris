import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/utils/color_const.dart';
import '../../../core/injector.dart';
import '../../widgets/approver_status_widget.dart';
import '../../widgets/data_widget.dart';
import '../../widgets/svg_icon_widget.dart';
import 'bloc/leave_detail_bloc.dart';

class LeaveDetailPage extends StatelessWidget {
  final int leaveId;
  final String? source;
  const LeaveDetailPage({
    Key? key,
    required this.leaveId,
    this.source,
  }) : super(key: key);

  // static Route route() {
  //   return MaterialPageRoute<void>(builder: (_) => const LeaveDetailPage());
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaveDetailBloc>(
      create: (context) => LeaveDetailBloc(
        getLeaveDetailUsecase: injector(),
        approveLeaveRequest: injector(),
        rejectLeaveRequest: injector(),
        patchLeaveStatus: injector(),
      )..add(LoadLeaveDetail(leaveId)),
      child: LeaveDetailPageView(
        source: source,
      ),
    );
  }
}

class LeaveDetailPageView extends StatelessWidget {
  final String? source;
  const LeaveDetailPageView({Key? key, this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Leave Detail',
        ),
        elevation: 0,
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
      ),
      bottomNavigationBar: BlocListener<LeaveDetailBloc, LeaveDetailState>(
        listener: (context, state) {
          if (state is PatchLeaveSuccess) {
            String docNumber =
                state.leaveDetailEntity.result.leaveDocumentNumber.toString();
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: 'Approved $docNumber',
            );
          }
        },
        child: BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
          builder: (context, state) {
            if (state is LeaveDetailLoadSuccess) {
              final data = state.leaveDetailEntity.result;
              if (data.leaveStatus != "waiting") {
                return const BottomAppBar();
              } else if (data.leaveStatus == "waiting" &&
                  source != null &&
                  source == "approval") {
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
                            _onRejectButtonPressed(context, data.leaveId);
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
                            _onApproveButtonPressed(context, data.leaveId);
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
                            _onCancelButtonPressed(context, data.leaveId);
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
                  source == "approval"
                      ? BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
                          builder: (context, state) {
                            if (state is LeaveDetailLoadSuccess) {
                              final data = state.leaveDetailEntity.result;
                              return Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      data.leaveRequesterProfilePicture,
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
                                        data.leaveRequesterName,
                                        style: textTheme.subtitle1,
                                      ),
                                      Text(
                                        data.leaveRequesterRole,
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
                  source == "approval"
                      ? SizedBox(
                          height: 20.h,
                        )
                      : const SizedBox.shrink(),
                  BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
                    builder: (context, state) {
                      if (state is LeaveDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.leaveDetailEntity.result.leaveDocumentNumber,
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
                          status: state.leaveDetailEntity.result.leaveStatus,
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
                  BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
                    builder: (context, state) {
                      if (state is LeaveDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.leaveDetailEntity.result.leaveType,
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
                          label: 'Leave Type',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_types.svg',
                          label: 'Leave Type',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
                    builder: (context, state) {
                      if (state is LeaveDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            '${state.leaveDetailEntity.result.leaveDateFrom} - ${state.leaveDetailEntity.result.leaveDateTo}',
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_dates.svg',
                          label: 'Tanggal',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_dates.svg',
                          label: 'Tanggal',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
                    builder: (context, state) {
                      if (state is LeaveDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          // data: '2 Hari',
                          data: ReadMoreText(
                            state.leaveDetailEntity.result.leaveDuration,
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
                          label: 'Durasi',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_duration.svg',
                          label: 'Durasi',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
                    builder: (context, state) {
                      if (state is LeaveDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.leaveDetailEntity.result.leaveNotes,
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
                  _AttachmentWidget(textTheme: textTheme),
                ],
              ),
            ),
            const Divider(
              color: Color(0xffF1FCFF),
              thickness: 10,
            ),
            _ApprovalWidget(textTheme: textTheme)
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
      BlocProvider.of<LeaveDetailBloc>(context).add(
        RejectLeaveRequest(leaveId, rejectReason.first),
      );
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
      BlocProvider.of<LeaveDetailBloc>(context).add(
        ApproveLeaveRequest(leaveId),
      );
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
      BlocProvider.of<LeaveDetailBloc>(context).add(
        PatchLeaveStatus(leaveId, "cancel", cancelReason.first),
      );
    }
  }
}

class _AttachmentWidget extends StatelessWidget {
  const _AttachmentWidget({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

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
                    BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
                      builder: (context, state) {
                        if (state is LeaveDetailLoadSuccess) {
                          if (state.leaveDetailEntity.result.leaveAttachment
                              .isNotEmpty) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state
                                  .leaveDetailEntity.result.leaveAttachment
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
                                          imageUrl: i.attachmentLink,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          i.attachmentName,
                                          style: textTheme.caption,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
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
    );
  }
}

class _ApprovalWidget extends StatelessWidget {
  const _ApprovalWidget({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        child: BlocBuilder<LeaveDetailBloc, LeaveDetailState>(
          builder: (context, state) {
            if (state is LeaveDetailLoadSuccess) {
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
                  ...state.leaveDetailEntity.result.leaveApprover.map(
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
    );
  }
}

class ShimmerLoadingData extends StatelessWidget {
  const ShimmerLoadingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Shimmer.fromColors(
        enabled: true,
        child: Container(
          width: double.infinity,
          height: 15.0,
          // color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
      ),
    );
  }
}
