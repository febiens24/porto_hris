import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../common/utils/color_const.dart';
import '../../../core/injector.dart';
import '../../attendance/attendance_detail/attendance_detail_page.dart';
import '../../leave/leave_page/leave_page.dart';
import '../../widgets/dashed_line.dart';
import '../../widgets/widget_toolbar.dart';
import '../swap_workdate_detail_page/swap_workdate_detail_page.dart';
import 'bloc/swap_workdate_list_bloc.dart';

class SwapWorkdateListPage extends StatelessWidget {
  const SwapWorkdateListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SwapWorkdateListBloc(
        getSwapWorkdateList: injector(),
      )..add(const LoadSwapWorkdateList()),
      child: const SwapWorkdateListPageView(),
    );
  }
}

class SwapWorkdateListPageView extends StatefulWidget {
  const SwapWorkdateListPageView({Key? key}) : super(key: key);

  @override
  State<SwapWorkdateListPageView> createState() =>
      _SwapWorkdateListPageViewState();
}

class _SwapWorkdateListPageViewState extends State<SwapWorkdateListPageView> {
  final _scrollController = ScrollController();

  FilterStatus _statusFilter = FilterStatus.all;
  FilterDate _dateFilter = FilterDate.all;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<SwapWorkdateListBloc>().add(const LoadSwapWorkdateList());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const WidgetToolBar(
              title: 'Swap Workdate',
            ),
            SizedBox(
              height: 50,
              child: BlocBuilder<SwapWorkdateListBloc, SwapWorkdateListState>(
                builder: (context, state) {
                  switch (state.status) {
                    case SwapWordateListState.initial:
                      return const ShimmerLoadingData();
                    case SwapWordateListState.success:
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (_, int index) {
                          switch (index) {
                            case 0:
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FilterChip(
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
                                                    onChanged:
                                                        (FilterStatus? value) {
                                                      setModalState(() {
                                                        _statusFilter = value!;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title:
                                                        const Text('Approved'),
                                                    value:
                                                        FilterStatus.approved,
                                                    groupValue: _statusFilter,
                                                    onChanged:
                                                        (FilterStatus? value) {
                                                      setModalState(() {
                                                        _statusFilter = value!;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title:
                                                        const Text('Rejected'),
                                                    value:
                                                        FilterStatus.rejected,
                                                    groupValue: _statusFilter,
                                                    onChanged:
                                                        (FilterStatus? value) {
                                                      setModalState(() {
                                                        _statusFilter = value!;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title:
                                                        const Text('Waiting'),
                                                    value: FilterStatus.waiting,
                                                    groupValue: _statusFilter,
                                                    onChanged:
                                                        (FilterStatus? value) {
                                                      setModalState(() {
                                                        _statusFilter = value!;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text('Cancel'),
                                                    value: FilterStatus.cancel,
                                                    groupValue: _statusFilter,
                                                    onChanged:
                                                        (FilterStatus? value) {
                                                      setModalState(() {
                                                        _statusFilter = value!;
                                                      });
                                                    },
                                                  ),
                                                  RadioListTile(
                                                    title: const Text('Draft'),
                                                    value: FilterStatus.draft,
                                                    groupValue: _statusFilter,
                                                    onChanged:
                                                        (FilterStatus? value) {
                                                      setModalState(() {
                                                        _statusFilter = value!;
                                                      });
                                                    },
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        print(
                                                          _statusFilter.name,
                                                        );
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: ColorConst
                                                            .defaultColor,
                                                      ),
                                                      child:
                                                          const Text('Apply'),
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
                              );
                            case 1:
                              return FilterChip(
                                avatar: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xffADADAD),
                                ),
                                label: Text(
                                  state.currentDateFilter,
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
                                                title: const Text(
                                                  'Semua tanggal',
                                                ),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 10,
                                                ),
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(_);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        ColorConst.defaultColor,
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
                              );
                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      );
                    case SwapWordateListState.failure:
                      return const Text('error');
                  }
                },
              ),
            ),
            BlocBuilder<SwapWorkdateListBloc, SwapWorkdateListState>(
              builder: (context, state) {
                switch (state.status) {
                  case SwapWordateListState.initial:
                    return const Center(child: CircularProgressIndicator());
                  case SwapWordateListState.success:
                    final swapWorkdates = state.swapWorkdates;
                    if (swapWorkdates.isEmpty) {
                      return const Center(child: Text('no posts'));
                    }
                    return Flexible(
                      child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: 20,
                          top: 5,
                        ).r,
                        itemCount: swapWorkdates.length,
                        itemBuilder: (BuildContext context, int index) {
                          final swapWorkdateData = swapWorkdates[index];
                          return Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SwapWorkdateDetailPage(
                                      swapworkdateId:
                                          swapWorkdateData.swapWorkdateId,
                                    ),
                                  ),
                                );
                              },
                              child: SimpleShadow(
                                opacity: 0.2, // Default: 0.5
                                sigma: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                width: 28,
                                                height: 28,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: swapWorkdateData
                                                              .swapWorkdateStatus ==
                                                          "Active"
                                                      ? const Color(0xff0B6238)
                                                      : swapWorkdateData
                                                                  .swapWorkdateStatus ==
                                                              "Inactive"
                                                          ? const Color(
                                                              0xffFF0B0B)
                                                          : const Color(
                                                              0xffCF8900),
                                                ),
                                                child: Image.asset(
                                                  'assets/icons/ic_notes2.png',
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Reprimand Number',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 9,
                                                    ),
                                                  ),
                                                  Text(
                                                    swapWorkdateData
                                                        .swapWorkdateDocumentNumber,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 9,
                                                  vertical: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                    color: swapWorkdateData
                                                                .swapWorkdateStatus ==
                                                            "Inactive"
                                                        ? const Color(
                                                            0xffFF0B0B)
                                                        : const Color(
                                                            0xff0B6238),
                                                  ),
                                                  color: swapWorkdateData
                                                              .swapWorkdateStatus ==
                                                          "Inactive"
                                                      ? const Color(0xffFFD7D7)
                                                      : const Color(0xffD7FFEB),
                                                ),
                                                child: Text(
                                                  swapWorkdateData
                                                      .swapWorkdateStatus,
                                                  style: TextStyle(
                                                    color: swapWorkdateData
                                                                .swapWorkdateStatus ==
                                                            "Inactive"
                                                        ? const Color(
                                                            0xffFF0B0B)
                                                        : const Color(
                                                            0xff0B6238),
                                                    fontSize: 9,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const DashedLine(
                                        dashWidth: 3,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                'assets/icons/ic_document.png',
                                                width: 32,
                                                height: 32,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Date',
                                                    style: TextStyle(
                                                      color: Color(0xff9F9F9F),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${swapWorkdateData.swapWorkdateWorkdate} - ${swapWorkdateData.swapWorkdateNewDate}',
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    // style: GoogleFonts.libreFranklin(
                                                    //   textStyle: const TextStyle(
                                                    //     fontSize: 10,
                                                    //     fontWeight: FontWeight.w500,
                                                    //   ),
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                'assets/icons/ic_bookmark.png',
                                                width: 32,
                                                height: 32,
                                              ),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Type',
                                                    style: TextStyle(
                                                      color: Color(0xff9F9F9F),
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    swapWorkdateData
                                                        .swapWorkdateNewDate,
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  case SwapWordateListState.failure:
                    return const Center(child: Text('failed to fetch posts'));
                }
                // if (state is SwapWorkdateListLoadSuccess) {
                //   final reprimands = state.reprimandList.result;
                //   return Flexible(
                //     child: ListView.separated(
                //       separatorBuilder: (context, index) {
                //         return const SizedBox(
                //           height: 10,
                //         );
                //       },
                //       padding: const EdgeInsets.only(
                //         right: 20,
                //         left: 20,
                //         bottom: 20,
                //         top: 5,
                //       ).r,
                //       itemCount: reprimands!.length,
                //       itemBuilder: (BuildContext context, int index) {
                //         final swapWorkdateData = reprimands[index];
                //         return Material(
                //           child: InkWell(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                   builder: (context) => SwapWorkdateDetailPage(
                //                     swapworkdateId:
                //                         swapWorkdateData.swapWorkdateId,
                //                   ),
                //                 ),
                //               );
                //             },
                //             child: SimpleShadow(
                //               opacity: 0.2, // Default: 0.5
                //               sigma: 10,
                //               child: Container(
                //                 padding: const EdgeInsets.all(20),
                //                 decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(6),
                //                   color: Colors.white,
                //                 ),
                //                 child: Column(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceEvenly,
                //                   children: [
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Row(
                //                           children: [
                //                             Container(
                //                               padding: const EdgeInsets.all(6),
                //                               width: 28,
                //                               height: 28,
                //                               decoration: BoxDecoration(
                //                                 shape: BoxShape.circle,
                //                                 color: swapWorkdateData
                //                                             .swapWorkdateStatus ==
                //                                         "Active"
                //                                     ? const Color(0xff0B6238)
                //                                     : swapWorkdateData
                //                                                 .swapWorkdateStatus ==
                //                                             "Inactive"
                //                                         ? const Color(
                //                                             0xffFF0B0B)
                //                                         : const Color(
                //                                             0xffCF8900),
                //                               ),
                //                               child: Image.asset(
                //                                 'assets/icons/ic_notes2.png',
                //                               ),
                //                             ),
                //                             const SizedBox(
                //                               width: 10,
                //                             ),
                //                             Column(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 const Text(
                //                                   'Reprimand Number',
                //                                   style: TextStyle(
                //                                     fontWeight: FontWeight.w300,
                //                                     fontSize: 9,
                //                                   ),
                //                                 ),
                //                                 Text(
                //                                   swapWorkdateData
                //                                       .swapWorkdateDocumentNumber,
                //                                   style: const TextStyle(
                //                                     fontWeight: FontWeight.bold,
                //                                     fontSize: 12,
                //                                   ),
                //                                 ),
                //                               ],
                //                             )
                //                           ],
                //                         ),
                //                         Row(
                //                           children: [
                //                             Container(
                //                               padding:
                //                                   const EdgeInsets.symmetric(
                //                                 horizontal: 9,
                //                                 vertical: 6,
                //                               ),
                //                               decoration: BoxDecoration(
                //                                 borderRadius:
                //                                     BorderRadius.circular(6),
                //                                 border: Border.all(
                //                                   color: swapWorkdateData
                //                                               .swapWorkdateStatus ==
                //                                           "Inactive"
                //                                       ? const Color(0xffFF0B0B)
                //                                       : const Color(0xff0B6238),
                //                                 ),
                //                                 color: swapWorkdateData
                //                                             .swapWorkdateStatus ==
                //                                         "Inactive"
                //                                     ? const Color(0xffFFD7D7)
                //                                     : const Color(0xffD7FFEB),
                //                               ),
                //                               child: Text(
                //                                 swapWorkdateData
                //                                     .swapWorkdateStatus,
                //                                 style: TextStyle(
                //                                   color: swapWorkdateData
                //                                               .swapWorkdateStatus ==
                //                                           "Inactive"
                //                                       ? const Color(0xffFF0B0B)
                //                                       : const Color(0xff0B6238),
                //                                   fontSize: 9,
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     ),
                //                     const SizedBox(
                //                       height: 10,
                //                     ),
                //                     const DashedLine(
                //                       dashWidth: 3,
                //                     ),
                //                     const SizedBox(
                //                       height: 20,
                //                     ),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Image.asset(
                //                               'assets/icons/ic_document.png',
                //                               width: 32,
                //                               height: 32,
                //                             ),
                //                             const SizedBox(
                //                               width: 7,
                //                             ),
                //                             Column(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 const Text(
                //                                   'Date',
                //                                   style: TextStyle(
                //                                     color: Color(0xff9F9F9F),
                //                                     fontSize: 12,
                //                                   ),
                //                                 ),
                //                                 const SizedBox(
                //                                   height: 5,
                //                                 ),
                //                                 Text(
                //                                   '${swapWorkdateData.swapWorkdateWorkdate} - ${swapWorkdateData.swapWorkdateNewDate}',
                //                                   style: const TextStyle(
                //                                     fontSize: 10,
                //                                     fontWeight: FontWeight.w500,
                //                                   ),
                //                                   // style: GoogleFonts.libreFranklin(
                //                                   //   textStyle: const TextStyle(
                //                                   //     fontSize: 10,
                //                                   //     fontWeight: FontWeight.w500,
                //                                   //   ),
                //                                   // ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                         Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Image.asset(
                //                               'assets/icons/ic_bookmark.png',
                //                               width: 32,
                //                               height: 32,
                //                             ),
                //                             const SizedBox(
                //                               width: 7,
                //                             ),
                //                             Column(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 const Text(
                //                                   'Type',
                //                                   style: TextStyle(
                //                                     color: Color(0xff9F9F9F),
                //                                     fontSize: 12,
                //                                   ),
                //                                 ),
                //                                 const SizedBox(
                //                                   height: 5,
                //                                 ),
                //                                 Text(
                //                                   swapWorkdateData
                //                                       .swapWorkdateNewDate,
                //                                   style: const TextStyle(
                //                                     fontSize: 10,
                //                                     fontWeight: FontWeight.w500,
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                       ],
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   );
                // } else {
                //   return const Center(
                //     child: CircularProgressIndicator(),
                //   );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
