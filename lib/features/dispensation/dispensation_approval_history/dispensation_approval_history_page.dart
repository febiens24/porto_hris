import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../common/utils/color_const.dart';
import '../../../common/utils/helper.dart';
import '../../../core/const.dart';
import '../../../core/injector.dart';
import '../../business_trip/business_trip_approval_history/business_trip_approval_history_page.dart';
import '../../leave/leave_page/leave_page.dart';
import '../dispensation_detail/dispensation_detail_page.dart';
import 'bloc/dispensation_approval_history_bloc.dart';

class DispensationApprovalHistoryPage extends StatelessWidget {
  const DispensationApprovalHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DispensationApprovalHistoryBloc(
        getDispensationApprovalHistoryList: injector(),
      )..add(const LoadDispensationApprovalHistoryList()),
      child: const DispensationApprovalHistoryPageView(),
    );
  }
}

class DispensationApprovalHistoryPageView extends StatefulWidget {
  const DispensationApprovalHistoryPageView({Key? key}) : super(key: key);

  @override
  State<DispensationApprovalHistoryPageView> createState() =>
      _DispensationApprovalHistoryPageViewState();
}

class _DispensationApprovalHistoryPageViewState
    extends State<DispensationApprovalHistoryPageView> {
  final _scrollController = ScrollController();

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
      context
          .read<DispensationApprovalHistoryBloc>()
          .add(const LoadDispensationApprovalHistoryList());
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

    FilterStatus _statusFilter = FilterStatus.all;
    FilterDate _dateFilter = FilterDate.all;

    String? _groupValue = 'all';

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
          BlocBuilder<DispensationApprovalHistoryBloc,
              DispensationApprovalHistoryState>(
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
                                        child: const Text(
                                          'Apply',
                                        ),
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
          BlocBuilder<DispensationApprovalHistoryBloc,
              DispensationApprovalHistoryState>(
            builder: (context, state) {
              switch (state.status) {
                case DispensationApprovalHistoryStatus.initial:
                  return const Center(child: CircularProgressIndicator());
                case DispensationApprovalHistoryStatus.success:
                  final dispensationDatas = state.dispensations;
                  if (dispensationDatas.isEmpty) {
                    return const Expanded(
                      child: EmptyWidget(),
                    );
                  } else {
                    return Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        itemCount: dispensationDatas.length,
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 10,
                          color: Color(0xffF1FCFF),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final dispensation = dispensationDatas[index];
                          return ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DispensationDetailPage(
                                  dispensationId: dispensation.dispensationId,
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
                              imageUrl: dispensation
                                  .dispensationRequesterProfilePicture!,
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
                                          dispensation
                                              .dispensationDocumentNumber,
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
                                            color: dispensation
                                                        .dispensationStatus ==
                                                    kApprovedStatus
                                                ? const Color(0xff0B6238)
                                                : dispensation
                                                            .dispensationStatus ==
                                                        kRejectedStatus
                                                    ? const Color(0xffFF0B0B)
                                                    : const Color(0xffCF8900),
                                          ),
                                          color: dispensation
                                                      .dispensationStatus ==
                                                  kApprovedStatus
                                              ? const Color(0xffD7FFEB)
                                              : dispensation
                                                          .dispensationStatus ==
                                                      kRejectedStatus
                                                  ? const Color(0xffFFD7D7)
                                                  : const Color(0xffFFE0A4),
                                        ),
                                        child: Text(
                                          dispensation.dispensationStatus,
                                          style:
                                              textTheme.labelMedium!.copyWith(
                                            color: dispensation
                                                        .dispensationStatus ==
                                                    kApprovedStatus
                                                ? const Color(0xff0B6238)
                                                : dispensation
                                                            .dispensationStatus ==
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
                                    '${dispensation.dispensationRequesterName} - ${dispensation.dispensationRequesterRole}',
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
                                        dispensation
                                                .dispensationClockType!.isEmpty
                                            ? '-'
                                            : dispensation
                                                .dispensationClockType!,
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
                                  dispensation.dispensationType,
                                  style: textTheme.bodySmall,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                case DispensationApprovalHistoryStatus.failure:
                  return const Center(child: Text('failed to fetch posts'));
              }
            },
          ),
        ],
      ),
    );
  }
}
