import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/utils/color_const.dart';
import '../../../../core/injector.dart';
import '../../../leave/leave_detail/leave_detail_page.dart';
import '../../../widgets/approver_status_widget.dart';
import '../../../widgets/data_widget.dart';
import '../../../widgets/svg_icon_widget.dart';
import '../bloc/business_trip_detail_bloc.dart';

class BusinessTripDetailPage extends StatelessWidget {
  final int businessTripId;
  final String? source;
  const BusinessTripDetailPage({
    Key? key,
    required this.businessTripId,
    this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BusinessTripDetailBloc>(
      create: (context) => BusinessTripDetailBloc(
        getBusinessTripDetail: injector(),
      )..add(
          LoadBusinessTripDetail(businessTripId),
        ),
      child: BusinessTripDetailView(
        source: source,
      ),
    );
  }
}

class BusinessTripDetailView extends StatefulWidget {
  final String? source;
  const BusinessTripDetailView({Key? key, this.source}) : super(key: key);

  @override
  State<BusinessTripDetailView> createState() => _BusinessTripDetailViewState();
}

class _BusinessTripDetailViewState extends State<BusinessTripDetailView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Business Trip Detail',
        ),
        elevation: 0,
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
      ),
      bottomNavigationBar:
          BlocBuilder<BusinessTripDetailBloc, BusinessTripDetailState>(
        builder: (context, state) {
          if (state is BusinessTripDetailLoadSuccess) {
            final data = state.businessTripDetail.result;
            if (data.businessTripStatus != "waiting") {
              return const BottomAppBar();
            } else if (data.businessTripStatus == "waiting" &&
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
                          _onRejectButtonPressed(context, data.businessTripId);
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
                          _onApproveButtonPressed(context, data.businessTripId);
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
                          _onCancelButtonPressed(context, data.businessTripId);
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
                  widget.source == "approval"
                      ? BlocBuilder<BusinessTripDetailBloc,
                          BusinessTripDetailState>(
                          builder: (context, state) {
                            if (state is BusinessTripDetailLoadSuccess) {
                              final data = state.businessTripDetail.result;
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
                                        data.businessTripProfilePicture),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.businessTripRequesterName,
                                        style: textTheme.subtitle1,
                                      ),
                                      Text(
                                        data.businessTripRequesterRole,
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
                  BlocBuilder<BusinessTripDetailBloc, BusinessTripDetailState>(
                    builder: (context, state) {
                      if (state is BusinessTripDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.businessTripDetail.result
                                .businessTripDocumentNumber,
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
                          status: state
                              .businessTripDetail.result.businessTripStatus,
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
                  BlocBuilder<BusinessTripDetailBloc, BusinessTripDetailState>(
                    builder: (context, state) {
                      if (state is BusinessTripDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.businessTripDetail.result.businessTripType,
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
                          label: 'Kegiatan',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_types.svg',
                          label: 'Kegiatan',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<BusinessTripDetailBloc, BusinessTripDetailState>(
                    builder: (context, state) {
                      if (state is BusinessTripDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            '${state.businessTripDetail.result.businessTripStartDate} - ${state.businessTripDetail.result.businessTripEndDate}',
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
                  DataWidget(
                    textTheme: textTheme,
                    // data: '2 Hari Kerja',
                    data: ReadMoreText(
                      '2 Hari Kerja',
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<BusinessTripDetailBloc, BusinessTripDetailState>(
                    builder: (context, state) {
                      if (state is BusinessTripDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state
                                .businessTripDetail.result.businessTripLocation,
                            trimLines: 2,
                            colorClickableText: const Color(0xff6792BA),
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' show less',
                            style: textTheme.bodySmall!.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          iconPath: 'assets/icons/ic_location.svg',
                          label: 'Alamat',
                        );
                      } else {
                        return DataWidget(
                          textTheme: textTheme,
                          data: const ShimmerLoadingData(),
                          iconPath: 'assets/icons/ic_location.svg',
                          label: 'Alamat',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<BusinessTripDetailBloc, BusinessTripDetailState>(
                    builder: (context, state) {
                      if (state is BusinessTripDetailLoadSuccess) {
                        return DataWidget(
                          textTheme: textTheme,
                          data: ReadMoreText(
                            state.businessTripDetail.result.businessTripNotes,
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
                                  BlocBuilder<BusinessTripDetailBloc,
                                      BusinessTripDetailState>(
                                    builder: (context, state) {
                                      if (state
                                          is BusinessTripDetailLoadSuccess) {
                                        if (state
                                            .businessTripDetail
                                            .result
                                            .businessTripAttachments
                                            .isNotEmpty) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: state.businessTripDetail
                                                .result.businessTripAttachments
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
                child: BlocBuilder<BusinessTripDetailBloc,
                    BusinessTripDetailState>(
                  builder: (context, state) {
                    if (state is BusinessTripDetailLoadSuccess) {
                      print(
                          'nilai ${state.businessTripDetail.result.businessTripApprovers[0].approverName}');
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
                          ...state
                              .businessTripDetail.result.businessTripApprovers
                              .map(
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
                          // ApproverStatusWidget(
                          //   textTheme: textTheme,
                          //   approverName: 'Human Resource',
                          //   date: '23 April 2022',
                          //   status: 'rejected',
                          // ),
                          // ApproverStatusWidget(
                          //   textTheme: textTheme,
                          //   approverName: 'Manager',
                          //   date: '24 April 2022',
                          //   status: 'rejected',
                          // ),
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
