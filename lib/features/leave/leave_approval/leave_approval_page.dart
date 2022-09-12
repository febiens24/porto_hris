import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/const.dart';
import '../../../core/injector.dart';
import '../../approval/empty_approval_page.dart';
import '../../approval/error_approval_page.dart';
import '../../widgets/widget_toolbar.dart';
import '../leave_approval_history/leave_approval_history_page.dart';
import '../leave_detail/leave_detail_page.dart';
import 'bloc/leave_approval_bloc.dart';

class LeaveApprovalPage extends StatelessWidget {
  const LeaveApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LeaveApprovalBloc>(
      create: (context) => LeaveApprovalBloc(
        getLeaveApprovalList: injector(),
        approveLeaveRequest: injector(),
        rejectLeaveRequest: injector(),
      )..add(LoadLeaveApprovalList()),
      child: const LeaveApprovalPageView(),
    );
  }
}

class LeaveApprovalPageView extends StatefulWidget {
  const LeaveApprovalPageView({Key? key}) : super(key: key);

  @override
  State<LeaveApprovalPageView> createState() => _LeaveApprovalPageViewState();
}

class _LeaveApprovalPageViewState extends State<LeaveApprovalPageView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool alive = true;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: ColorConst.defaultColor,
      //   centerTitle: true,
      //   title: const Text('Approval'),
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => const LeaveApprovalHistoryPage(),
      //           ),
      //         );
      //       },
      //       icon: const Icon(Icons.history_outlined),
      //     ),
      //   ],
      // ),
      body: BlocListener<LeaveApprovalBloc, LeaveApprovalState>(
        listener: (context, state) {
          if (state is LeaveApprovalLoadSuccess) {
            final leaveApprovals = state.leaveApproval.result;
            if (leaveApprovals!.isEmpty) {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const EmptyApprovalPage(
                    source: kLeave,
                  ),
                ),
              );
            }
          } else if (state is LeaveApprovalLoadFailure) {
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
        child: BlocBuilder<LeaveApprovalBloc, LeaveApprovalState>(
          builder: (context, state) {
            if (state is LeaveApprovalLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LeaveApprovalLoadSuccess) {
              final leaveApprovals = state.leaveApproval.result;
              return SafeArea(
                child: Column(
                  children: [
                    WidgetToolBar(
                      title: 'Leave',
                      actionButton: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LeaveApprovalHistoryPage(),
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
                            'Ada ${leaveApprovals!.length} permohonan yang harus diproses',
                            style: textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<LeaveApprovalBloc>(context).add(
                            LoadLeaveApprovalList(),
                          );
                        },
                        child: ListView.separated(
                          itemCount: leaveApprovals.length,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 10,
                            color: Color(0xffF1FCFF),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final leaveApproval = leaveApprovals[index];
                            if (alive) {
                              return Slidable(
                                key: Key(leaveApproval.leaveDocumentNumber),
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
                                      onPressed: (context) {
                                        BlocProvider.of<LeaveApprovalBloc>(
                                                context)
                                            .add(
                                          ApproveLeaveRequest(
                                            leaveApproval.leaveId,
                                          ),
                                        );
                                      },
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
                                        builder: (context) => LeaveDetailPage(
                                          leaveId: leaveApproval.leaveId,
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
                                    imageUrl: leaveApproval
                                        .leaveRequesterProfilePicture!,
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
                                        leaveApproval.leaveDocumentNumber,
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
                                              leaveApproval.leaveRequesterName!,
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
                                              leaveApproval.leaveType,
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
                                            '${leaveApproval.leaveDateFrom} - ${leaveApproval.leaveDateTo} ',
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
