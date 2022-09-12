import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../common/utils/color_const.dart';
import '../../../common/utils/helper.dart';
import '../../../core/injector.dart';
import '../../attendance/attendance_detail/attendance_detail_page.dart';
import '../../leave/leave_page/leave_page.dart';
import '../../widgets/dashed_line.dart';
import '../../widgets/widget_toolbar.dart';
import '../reprimand_detail_page/reprimand_detail_page.dart';
import 'bloc/reprimand_list_bloc.dart';

class ReprimandListPage extends StatelessWidget {
  const ReprimandListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReprimandListBloc(
        getReprimandList: injector(),
      )..add(const LoadReprimandList()),
      child: const ReprimandListPageView(),
    );
  }
}

class ReprimandListPageView extends StatefulWidget {
  const ReprimandListPageView({Key? key}) : super(key: key);

  @override
  State<ReprimandListPageView> createState() => _ReprimandListPageViewState();
}

class _ReprimandListPageViewState extends State<ReprimandListPageView> {
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
      context.read<ReprimandListBloc>().add(const LoadReprimandList());
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

    String? _groupValue = 'all';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // const WidgetToolBar(
            //   title: 'Reprimand',
            // ),
            BlocBuilder<ReprimandListBloc, ReprimandListState>(
              builder: (context, state) {
                switch (state.status) {
                  case ReprimandListStatus.initial:
                    return const SizedBox.shrink();
                  case ReprimandListStatus.success:
                    return WidgetToolBar(
                      title: 'Reprimand',
                      onSubmitted: (query) {
                        // print(query);
                        BlocProvider.of<ReprimandListBloc>(context).add(
                          LoadReprimandList(
                            q: query.isEmpty ? null : query,
                            status: state.currentStateFilter,
                            type: state.currentTypeFilter,
                            dateFilter: state.currentDateFilter,
                          ),
                        );
                      },
                    );
                  case ReprimandListStatus.failure:
                    return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 50,
              child: BlocBuilder<ReprimandListBloc, ReprimandListState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ReprimandListStatus.initial:
                      return const ShimmerLoadingData();
                    case ReprimandListStatus.success:
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
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
                                                        BlocProvider.of<
                                                                    ReprimandListBloc>(
                                                                context)
                                                            .add(
                                                                LoadReprimandList(
                                                          status: _statusFilter
                                                              .name,
                                                          dateFilter: state
                                                              .currentDateFilter,
                                                          type: state
                                                              .currentTypeFilter,
                                                          q: state.searchQuery,
                                                        ));
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
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FilterChip(
                                  avatar: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xffADADAD),
                                  ),
                                  label: Text(
                                    state.currentTypeFilter.contains('all')
                                        ? 'Semua tipe'
                                        : state.currentTypeFilter,
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
                                                  RadioListTile<String>(
                                                    title: const Text(
                                                      'Semua tipe',
                                                    ),
                                                    value: 'all',
                                                    groupValue: _groupValue,
                                                    onChanged: (String? value) {
                                                      setModalState(() {
                                                        _groupValue = value;
                                                      });
                                                    },
                                                  ),
                                                  ...state.listTypes.map((e) {
                                                    return RadioListTile<
                                                        String>(
                                                      title: Text(e),
                                                      value: e,
                                                      groupValue: _groupValue,
                                                      onChanged:
                                                          (String? value) {
                                                        setModalState(() {
                                                          _groupValue = value;
                                                        });
                                                      },
                                                    );
                                                  }),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10,
                                                    ),
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(_);
                                                        BlocProvider.of<
                                                                    ReprimandListBloc>(
                                                                context)
                                                            .add(
                                                                LoadReprimandList(
                                                          status: state
                                                              .currentStateFilter,
                                                          dateFilter: state
                                                              .currentDateFilter,
                                                          type: _groupValue,
                                                          q: state.searchQuery,
                                                        ));
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
                            case 2:
                              return FilterChip(
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
                                                title:
                                                    const Text('Semua tanggal'),
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
                                                    BlocProvider.of<
                                                                ReprimandListBloc>(
                                                            context)
                                                        .add(LoadReprimandList(
                                                      status: state
                                                          .currentStateFilter,
                                                      dateFilter:
                                                          _dateFilter.name,
                                                      type: state
                                                          .currentTypeFilter,
                                                      q: state.searchQuery,
                                                    ));
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
                    case ReprimandListStatus.failure:
                      return const Text('error');
                  }
                },
              ),
            ),
            BlocBuilder<ReprimandListBloc, ReprimandListState>(
              builder: (context, state) {
                switch (state.status) {
                  case ReprimandListStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  case ReprimandListStatus.success:
                    final reprimands = state.reprimands;
                    if (reprimands.isEmpty) {
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
                        itemCount: reprimands.length,
                        itemBuilder: (BuildContext context, int index) {
                          final reprimandData = reprimands[index];
                          return Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReprimandDetailPage(
                                      reprimandId: reprimandData.reprimandId,
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
                                                  color: reprimandData
                                                              .reprimandStatus ==
                                                          "Active"
                                                      ? const Color(0xff0B6238)
                                                      : reprimandData
                                                                  .reprimandStatus ==
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
                                                    reprimandData
                                                        .reprimandDocumentNumber,
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
                                                    color: reprimandData
                                                                .reprimandStatus ==
                                                            "Inactive"
                                                        ? const Color(
                                                            0xffFF0B0B)
                                                        : const Color(
                                                            0xff0B6238),
                                                  ),
                                                  color: reprimandData
                                                              .reprimandStatus ==
                                                          "Inactive"
                                                      ? const Color(0xffFFD7D7)
                                                      : const Color(0xffD7FFEB),
                                                ),
                                                child: Text(
                                                  reprimandData.reprimandStatus,
                                                  style: TextStyle(
                                                    color: reprimandData
                                                                .reprimandStatus ==
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
                                                    '${reprimandData.reprimandEffectiveDate} - ${reprimandData.reprimandExpirationDate}',
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
                                                    reprimandData.reprimandType,
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
                  case ReprimandListStatus.failure:
                    return const Center(child: Text('failed to fetch posts'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
