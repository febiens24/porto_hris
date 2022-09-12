import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../business_trip/business_trip_approval_history/business_trip_approval_history_page.dart';
import 'package:intl/intl.dart';
import '../../../common/utils/color_const.dart';
import '../../../common/utils/helper.dart';
import '../../../core/injector.dart';

import '../../../core/const.dart';
import '../../leave/leave_page/leave_page.dart';
import '../swap_workdate_detail_page/swap_workdate_detail_page.dart';
import 'bloc/swap_workdate_approval_history_bloc.dart';

class SwapWorkdateApprovalHistoryPage extends StatelessWidget {
  const SwapWorkdateApprovalHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SwapWorkdateApprovalHistoryBloc(
        getSwapWorkdateApprovalHistoryList: injector(),
      )..add(const LoadSwapWorkdateApprovalHistoryList()),
      child: const SwapWorkdateApprovalHistoryPageView(),
    );
  }
}

class SwapWorkdateApprovalHistoryPageView extends StatefulWidget {
  const SwapWorkdateApprovalHistoryPageView({Key? key}) : super(key: key);

  @override
  State<SwapWorkdateApprovalHistoryPageView> createState() =>
      _SwapWorkdateApprovalHistoryPageViewState();
}

class _SwapWorkdateApprovalHistoryPageViewState
    extends State<SwapWorkdateApprovalHistoryPageView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    FilterStatus _statusFilter = FilterStatus.all;
    FilterDate _dateFilter = FilterDate.all;

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
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
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
          BlocBuilder<SwapWorkdateApprovalHistoryBloc,
              SwapWorkdateApprovalHistoryState>(
            builder: (context, state) {
              return SizedBox(
                height: kToolbarHeight,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    FilterChip(
                      avatar: const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xffADADAD),
                      ),
                      label: Text(
                        state.currentStateFilter.contains('all')
                            ? 'Semua status'
                            : toBeginningOfSentenceCase(
                                state.currentStateFilter,
                              )!,
                        style: textTheme.caption,
                      ),
                      onSelected: (bool value) {
                        showModalBottomSheet<int>(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return StatefulBuilder(builder: (
                              _,
                              StateSetter setModalState,
                            ) {
                              return Popover(
                                child: Expanded(
                                  child: ListView(
                                    children: [
                                      RadioListTile(
                                        title: const Text(
                                          'Semua status',
                                        ),
                                        value: FilterStatus.all,
                                        groupValue: _statusFilter,
                                        onChanged: (FilterStatus? value) {
                                          setModalState(() {
                                            _statusFilter = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('Approved'),
                                        value: FilterStatus.approved,
                                        groupValue: _statusFilter,
                                        onChanged: (FilterStatus? value) {
                                          setModalState(() {
                                            _statusFilter = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('Rejected'),
                                        value: FilterStatus.rejected,
                                        groupValue: _statusFilter,
                                        onChanged: (FilterStatus? value) {
                                          setModalState(() {
                                            _statusFilter = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('Waiting'),
                                        value: FilterStatus.waiting,
                                        groupValue: _statusFilter,
                                        onChanged: (FilterStatus? value) {
                                          setModalState(() {
                                            _statusFilter = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('Cancel'),
                                        value: FilterStatus.cancel,
                                        groupValue: _statusFilter,
                                        onChanged: (FilterStatus? value) {
                                          setModalState(() {
                                            _statusFilter = value!;
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: const Text('Draft'),
                                        value: FilterStatus.draft,
                                        groupValue: _statusFilter,
                                        onChanged: (FilterStatus? value) {
                                          setModalState(() {
                                            _statusFilter = value!;
                                          });
                                        },
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            primary: ColorConst.defaultColor,
                                          ),
                                          child: const Text('Apply'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                      side: const BorderSide(
                        color: Color(0xffADADAD),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FilterChip(
                      avatar: const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xffADADAD),
                      ),
                      label: Text(
                        state.currentDateFilter.contains('all')
                            ? 'Semua tanggal'
                            : dateFilterManipulation(
                                state.currentDateFilter,
                              ),
                        style: textTheme.caption,
                      ),
                      onSelected: (bool value) {
                        showModalBottomSheet<int>(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return StatefulBuilder(builder: (
                              _,
                              StateSetter setModalState,
                            ) {
                              return Popover(
                                child: Column(
                                  children: [
                                    RadioListTile<FilterDate>(
                                      title: const Text('Semua tanggal'),
                                      value: FilterDate.all,
                                      groupValue: _dateFilter,
                                      onChanged: (FilterDate? value) {
                                        setModalState(() {
                                          _dateFilter = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<FilterDate>(
                                      title: const Text(
                                        '30 Hari Terakhir',
                                      ),
                                      value: FilterDate.thirtydays,
                                      groupValue: _dateFilter,
                                      onChanged: (FilterDate? value) {
                                        setModalState(() {
                                          _dateFilter = value!;
                                        });
                                      },
                                    ),
                                    RadioListTile<FilterDate>(
                                      title: const Text(
                                        '90 Hari Terakhir',
                                      ),
                                      value: FilterDate.ninetydays,
                                      groupValue: _dateFilter,
                                      onChanged: (FilterDate? value) {
                                        setModalState(() {
                                          _dateFilter = value!;
                                        });
                                      },
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorConst.defaultColor,
                                        ),
                                        child: const Text('Apply'),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      },
                      side: const BorderSide(
                        color: Color(0xffADADAD),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              );
            },
          ),
          BlocBuilder<SwapWorkdateApprovalHistoryBloc,
              SwapWorkdateApprovalHistoryState>(
            builder: (context, state) {
              switch (state.status) {
                case SwapWorkdateHistoryListStatus.initial:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case SwapWorkdateHistoryListStatus.success:
                  final swapWorkdateDatas = state.swapworkdates;
                  if (swapWorkdateDatas.isEmpty) {
                    return const Expanded(child: EmptyWidget());
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: swapWorkdateDatas.length,
                        // padding: const EdgeInsets.symmetric(vertical: 20),
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 10,
                          color: Color(0xffF1FCFF),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final swapWorkdate = swapWorkdateDatas[index];
                          return ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SwapWorkdateDetailPage(
                                  swapworkdateId: swapWorkdate.swapWorkdateId,
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
                                  swapWorkdate.swapWorkdateProfilePicture!,
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
                                          swapWorkdate
                                              .swapWorkdateDocumentNumber,
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
                                            color: swapWorkdate
                                                        .swapWorkdateStatus ==
                                                    kApprovedStatus
                                                ? const Color(0xff0B6238)
                                                : swapWorkdate
                                                            .swapWorkdateStatus ==
                                                        kRejectedStatus
                                                    ? const Color(0xffFF0B0B)
                                                    : const Color(0xffCF8900),
                                          ),
                                          color: swapWorkdate
                                                      .swapWorkdateStatus ==
                                                  kApprovedStatus
                                              ? const Color(0xffD7FFEB)
                                              : swapWorkdate
                                                          .swapWorkdateStatus ==
                                                      kRejectedStatus
                                                  ? const Color(0xffFFD7D7)
                                                  : const Color(0xffFFE0A4),
                                        ),
                                        child: Text(
                                          swapWorkdate.swapWorkdateStatus,
                                          style:
                                              textTheme.labelMedium!.copyWith(
                                            color: swapWorkdate
                                                        .swapWorkdateStatus ==
                                                    kApprovedStatus
                                                ? const Color(0xff0B6238)
                                                : swapWorkdate
                                                            .swapWorkdateStatus ==
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
                                    '${swapWorkdate.swapWorkdateRequesterName} - ${swapWorkdate.swapWorkdateRequesterRole}',
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
                                        swapWorkdate.swapWorkdateNotes,
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
                                  '${swapWorkdate.swapWorkdateWorkdate} - ${swapWorkdate.swapWorkdateNewDate}',
                                  style: textTheme.bodySmall,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                case SwapWorkdateHistoryListStatus.failure:
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
