import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/const.dart';
import '../../../core/injector.dart';
import '../../approval/empty_approval_page.dart';
import '../../approval/error_approval_page.dart';
import '../../widgets/widget_toolbar.dart';
import '../overtime_approval_history/overtime_approval_history_page.dart';
import '../overtime_detail/overtime_detail_page.dart';
import 'bloc/overtime_approval_bloc.dart';

class OvertimeApprovalPage extends StatelessWidget {
  const OvertimeApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OvertimeApprovalBloc(
        getOvertimeApprovalList: injector(),
      )..add(LoadOvertimeApprovalList()),
      child: const OvertimeApprovalPageView(),
    );
  }
}

class OvertimeApprovalPageView extends StatefulWidget {
  const OvertimeApprovalPageView({Key? key}) : super(key: key);

  @override
  State<OvertimeApprovalPageView> createState() =>
      _OvertimeApprovalPageViewState();
}

class _OvertimeApprovalPageViewState extends State<OvertimeApprovalPageView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool alive = true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<OvertimeApprovalBloc, OvertimeApprovalState>(
        listener: (context, state) {
          if (state is OvertimeApprovalLoadSuccess) {
            final leaveApprovals = state.overtimeApproval.result;
            if (leaveApprovals!.isEmpty) {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const EmptyApprovalPage(
                    source: kOvertime,
                  ),
                ),
              );
            }
          } else if (state is OvertimeApprovalLoadFailure) {
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
        child: BlocBuilder<OvertimeApprovalBloc, OvertimeApprovalState>(
          builder: (context, state) {
            if (state is OvertimeApprovalLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OvertimeApprovalLoadSuccess) {
              final overtimeApprovals = state.overtimeApproval.result;
              return SafeArea(
                child: Column(
                  children: [
                    WidgetToolBar(
                      title: 'Overtime',
                      actionButton: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const OvertimeApprovalHistoryPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                            'Ada ${overtimeApprovals!.length} permohonan yang harus diproses',
                            style: textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<OvertimeApprovalBloc>(context).add(
                            LoadOvertimeApprovalList(),
                          );
                        },
                        child: ListView.separated(
                          itemCount: overtimeApprovals.length,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 10,
                            color: Color(0xffF1FCFF),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final overtimeApproval = overtimeApprovals[index];
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
                                            OvertimeDetailPage(
                                          overtimeId:
                                              overtimeApproval.overtimeId,
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
                                    imageUrl: overtimeApproval
                                        .overtimeProfilePicture!,
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
                                        overtimeApproval.overtimeDocumentNumber,
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
                                              overtimeApproval
                                                  .overtimeRequesterName!,
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
                                              overtimeApproval.overtimeType,
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
                                            '${overtimeApproval.overtimeDateFrom} - ${overtimeApproval.overtimeDateTo} ',
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
