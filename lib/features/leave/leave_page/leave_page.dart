import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/color_const.dart';
import '../../../common/utils/helper.dart';
import '../../../core/injector.dart';
import '../../widgets/dashed_line.dart';
import '../../widgets/status_widget.dart';
import '../../widgets/widget_toolbar.dart';
import '../leave_detail/leave_detail_page.dart';
import '../request_leave/request_leave_page.dart';
import 'bloc/leave_bloc.dart';

enum FilterStatus { all, approved, rejected, waiting, cancel, draft }

enum FilterDate { all, thirtydays, ninetydays }

class LeavePage extends StatelessWidget {
  const LeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaveBloc>(
      create: (context) => LeaveBloc(
        getLeaveList: injector(),
      )..add(const LoadLeaveList()),
      child: const LeavePageView(),
    );
  }
}

class LeavePageView extends StatefulWidget {
  const LeavePageView({Key? key}) : super(key: key);

  @override
  State<LeavePageView> createState() => _LeavePageViewState();
}

class _LeavePageViewState extends State<LeavePageView> {
  final _scrollController = ScrollController();

  // Widget _buildListItem(
  //   BuildContext context, {
  //   Widget? title,
  //   Widget? leading,
  //   Widget? trailing,
  // }) {
  //   final theme = Theme.of(context);

  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 24.0,
  //       vertical: 16.0,
  //     ),
  //     decoration: BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(
  //           color: theme.dividerColor,
  //           width: 0.5,
  //         ),
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         if (leading != null) leading,
  //         if (title != null)
  //           Padding(
  //             padding: const EdgeInsets.symmetric(
  //               horizontal: 16.0,
  //             ),
  //             child: DefaultTextStyle(
  //               child: title,
  //               style: theme.textTheme.titleSmall!,
  //             ),
  //           ),
  //         const Spacer(),
  //         if (trailing != null) trailing,
  //       ],
  //     ),
  //   );
  // }

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
    if (_isBottom) context.read<LeaveBloc>().add(const LoadLeaveList());
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

    FilterStatus _statusFilter = FilterStatus.all;
    FilterDate _dateFilter = FilterDate.all;

    String? _groupValue = 'all';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConst.defaultColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RequestLeavePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                switch (state.status) {
                  case LeaveStatus.initial:
                    return const SizedBox.shrink();
                  case LeaveStatus.success:
                    return WidgetToolBar(
                      title: 'Leave',
                      onSubmitted: (query) {
                        // print(query);
                        BlocProvider.of<LeaveBloc>(context).add(
                          LoadLeaveList(
                            q: query.isEmpty ? null : query,
                            status: state.currentStateFilter,
                            type: state.currentTypeFilter,
                            dateFilter: state.currentDateFilter,
                          ),
                        );
                      },
                    );
                  case LeaveStatus.failure:
                    return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 50,
              child: BlocBuilder<LeaveBloc, LeaveState>(
                builder: (context, state) {
                  switch (state.status) {
                    case LeaveStatus.initial:
                      return const ShimmerLoadingData();
                    case LeaveStatus.failure:
                      return const Text('error');
                    case LeaveStatus.success:
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
                                                                    LeaveBloc>(
                                                                context)
                                                            .add(LoadLeaveList(
                                                          status: _statusFilter
                                                              .name,
                                                          dateFilter:
                                                              _dateFilter.name,
                                                          q: state.searchQuery,
                                                          type: state
                                                              .currentTypeFilter,
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
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                      itemCount: state
                                                          .listTypes.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final data = state
                                                            .listTypes[index];
                                                        return index == 0
                                                            ? RadioListTile<
                                                                String>(
                                                                title:
                                                                    const Text(
                                                                  'Semua tipe',
                                                                ),
                                                                value: 'all',
                                                                groupValue:
                                                                    _groupValue,
                                                                onChanged:
                                                                    (String?
                                                                        value) {
                                                                  setModalState(
                                                                      () {
                                                                    _groupValue =
                                                                        value;
                                                                  });
                                                                },
                                                              )
                                                            : RadioListTile<
                                                                String>(
                                                                title:
                                                                    Text(data),
                                                                value: data,
                                                                groupValue:
                                                                    _groupValue,
                                                                onChanged:
                                                                    (String?
                                                                        value) {
                                                                  setModalState(
                                                                      () {
                                                                    _groupValue =
                                                                        value;
                                                                  });
                                                                },
                                                              );
                                                      },
                                                    ),
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
                                                                    LeaveBloc>(
                                                                context)
                                                            .add(LoadLeaveList(
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
                                                      child: const Text(
                                                        'Apply',
                                                      ),
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
                                                    BlocProvider.of<LeaveBloc>(
                                                            context)
                                                        .add(LoadLeaveList(
                                                      status: state
                                                          .currentStateFilter,
                                                      dateFilter:
                                                          _dateFilter.name,
                                                      q: state.searchQuery,
                                                      type: state
                                                          .currentTypeFilter,
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
            BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                switch (state.status) {
                  case LeaveStatus.failure:
                    return const Center(child: Text('failed to fetch posts'));
                  case LeaveStatus.success:
                    if (state.leaves.isEmpty) {
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
                        itemCount: state.hasReachedMax
                            ? state.leaves.length
                            : state.leaves.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          final leaveData = state.leaves[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LeaveDetailPage(
                                    leaveId: leaveData.leaveId,
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
                                                color: leaveData.leaveStatus ==
                                                        "approved"
                                                    ? const Color(0xff0B6238)
                                                    : leaveData.leaveStatus ==
                                                            "approved"
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
                                                  style: textTheme.labelMedium,
                                                ),
                                                Text(
                                                  leaveData.leaveDocumentNumber,
                                                  style: textTheme.labelMedium,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        StatusWidget(
                                          status: leaveData.leaveStatus,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                    'Type',
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
                                                    leaveData.leaveType,
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
                                                    leaveData.leaveRequestDate,
                                                    style:
                                                        textTheme.labelMedium!,
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
                          );
                        },
                      ),
                    );
                  // return ListView.builder(
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return index >= state.leaves.length
                  //         ? const BottomLoader()
                  //         : PostListItem(post: state.posts[index]);
                  //   },
                  //   itemCount: state.hasReachedMax
                  //       ? state.leaves.length
                  //       : state.leaves.length + 1,
                  //   controller: _scrollController,
                  // );
                  case LeaveStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class Popover extends StatelessWidget {
  const Popover({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(context),
          child,
        ],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}
