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
import '../../widgets/status_widget.dart';
import '../../widgets/widget_toolbar.dart';
import '../overtime_detail/overtime_detail_page.dart';
import '../request_overtime/request_overtime_page.dart';
import 'bloc/overtime_list_bloc.dart';

class OvertimePage extends StatelessWidget {
  const OvertimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OvertimeListBloc>(
      create: (context) => OvertimeListBloc(
        getOvertimeList: injector(),
      )..add(const LoadOvertimeList()),
      child: const OvertimePageView(),
    );
  }
}

class OvertimePageView extends StatefulWidget {
  const OvertimePageView({Key? key}) : super(key: key);

  @override
  State<OvertimePageView> createState() => _OvertimePageViewState();
}

class _OvertimePageViewState extends State<OvertimePageView> {
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
      context.read<OvertimeListBloc>().add(const LoadOvertimeList());
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
            //   title: 'Overtime',
            // ),
            BlocBuilder<OvertimeListBloc, OvertimeListState>(
              builder: (context, state) {
                switch (state.status) {
                  case OvertimeListStatus.initial:
                    return const SizedBox.shrink();
                  case OvertimeListStatus.success:
                    return WidgetToolBar(
                      title: 'Overtime',
                      onSubmitted: (query) {
                        // print(query);
                        BlocProvider.of<OvertimeListBloc>(context).add(
                          LoadOvertimeList(
                            q: query.isEmpty ? null : query,
                            status: state.currentStateFilter,
                            type: state.currentTypeFilter,
                            dateFilter: state.currentDateFilter,
                          ),
                        );
                      },
                    );
                  case OvertimeListStatus.failure:
                    return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 50,
              child: BlocBuilder<OvertimeListBloc, OvertimeListState>(
                builder: (context, state) {
                  switch (state.status) {
                    case OvertimeListStatus.initial:
                      return const ShimmerLoadingData();
                    case OvertimeListStatus.failure:
                      return const Text('error');
                    case OvertimeListStatus.success:
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
                                                        Navigator.pop(_);
                                                        BlocProvider.of<
                                                                    OvertimeListBloc>(
                                                                context)
                                                            .add(
                                                                LoadOvertimeList(
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
                                            child: Column(
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
                                                  return RadioListTile<String>(
                                                    title: Text(e),
                                                    value: e,
                                                    groupValue: _groupValue,
                                                    onChanged: (String? value) {
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
                                                                  OvertimeListBloc>(
                                                              context)
                                                          .add(LoadOvertimeList(
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
                                                                OvertimeListBloc>(
                                                            context)
                                                        .add(LoadOvertimeList(
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
                    default:
                      return const Text('error');
                  }
                },
              ),
            ),
            BlocBuilder<OvertimeListBloc, OvertimeListState>(
              builder: (context, state) {
                switch (state.status) {
                  case OvertimeListStatus.failure:
                    return const Center(child: Text('failed to fetch posts'));
                  case OvertimeListStatus.success:
                    final overtimesData = state.overtimes;
                    if (overtimesData.isEmpty) {
                      return const Center(child: Text('no posts'));
                    }
                    return Flexible(
                      child: ListView.separated(
                        controller: _scrollController,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: 20,
                          top: 5,
                        ).r,
                        itemCount: overtimesData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final overtimeData = overtimesData[index];
                          return Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OvertimeDetailPage(
                                      overtimeId: overtimeData.overtimeId,
                                    ),
                                  ),
                                );
                              },
                              child: SimpleShadow(
                                opacity: 0.2, // Default: 0.5
                                sigma: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(20).r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6).r,
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
                                                    const EdgeInsets.all(6).r,
                                                width: 28.h,
                                                height: 28.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: overtimeData
                                                              .overtimeStatus ==
                                                          "Approved"
                                                      ? const Color(0xff0B6238)
                                                      : overtimeData
                                                                  .overtimeStatus ==
                                                              "Rejected"
                                                          ? const Color(
                                                              0xffFF0B0B)
                                                          : const Color(
                                                              0xffCF8900),
                                                ),
                                                child: Image.asset(
                                                  'assets/icons/ic_briefcase2.png',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Number',
                                                    style:
                                                        textTheme.labelMedium,
                                                  ),
                                                  Text(
                                                    overtimeData
                                                        .overtimeDocumentNumber,
                                                    style:
                                                        textTheme.labelMedium,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          StatusWidget(
                                            status: overtimeData.overtimeStatus,
                                            textTheme: textTheme,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      const DashedLine(
                                        dashWidth: 3,
                                      ),
                                      SizedBox(
                                        height: 20.h,
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
                                                'assets/icons/ic_arrow.png',
                                                width: 20.h,
                                                height: 20.h,
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Overtime Type',
                                                      style: textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                        color: const Color(
                                                            0xff9F9F9F),
                                                        // fontSize: 12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      overtimeData.overtimeType,
                                                      style:
                                                          textTheme.labelMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                'assets/icons/ic_bookmark.png',
                                                width: 20.h,
                                                height: 20.h,
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Request Date',
                                                      style: textTheme
                                                          .labelMedium!
                                                          .copyWith(
                                                        color: const Color(
                                                            0xff9F9F9F),
                                                        // fontSize: 12.sp,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    Text(
                                                      overtimeData
                                                          .overtimeRequestedDate,
                                                      style: textTheme
                                                          .labelMedium!,
                                                    ),
                                                  ],
                                                ),
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
                  case OvertimeListStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConst.defaultColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RequestOvertimePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
