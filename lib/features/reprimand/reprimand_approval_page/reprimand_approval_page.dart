import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/const.dart';
import '../../../core/injector.dart';
import '../../approval/empty_approval_page.dart';
import '../../approval/error_approval_page.dart';
import '../../widgets/widget_toolbar.dart';
import '../reprimand_approval_history/reprimand_approval_history_page.dart';
import '../reprimand_detail_page/reprimand_detail_page.dart';
import 'bloc/reprimand_approval_bloc.dart';

class ReprimandApprovalPage extends StatelessWidget {
  const ReprimandApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReprimandApprovalBloc(
        getReprimandApprovalList: injector(),
      )..add(LoadReprimandApprovalList()),
      child: const ReprimandApprovalPageView(),
    );
  }
}

class ReprimandApprovalPageView extends StatefulWidget {
  const ReprimandApprovalPageView({Key? key}) : super(key: key);

  @override
  State<ReprimandApprovalPageView> createState() =>
      _ReprimandApprovalPageViewState();
}

class _ReprimandApprovalPageViewState extends State<ReprimandApprovalPageView> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool alive = true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<ReprimandApprovalBloc, ReprimandApprovalState>(
        listener: (context, state) {
          if (state is ReprimandApprovalLoadSuccess) {
            final leaveApprovals = state.reprimandApprovals.result;
            if (leaveApprovals!.isEmpty) {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const EmptyApprovalPage(
                    source: kReprimand,
                  ),
                ),
              );
            }
          } else if (state is ReprimandApprovalLoadFailure) {
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
        child: BlocBuilder<ReprimandApprovalBloc, ReprimandApprovalState>(
          builder: (context, state) {
            if (state is ReprimandApprovalLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ReprimandApprovalLoadSuccess) {
              final reprimandApprovals = state.reprimandApprovals.result;
              return SafeArea(
                child: Column(
                  children: [
                    WidgetToolBar(
                      title: 'Reprimand',
                      actionButton: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ReprimandApprovalHistoryPage(),
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
                            'Ada ${reprimandApprovals!.length} permohonan yang harus diproses',
                            style: textTheme.bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<ReprimandApprovalBloc>(context).add(
                            LoadReprimandApprovalList(),
                          );
                        },
                        child: ListView.separated(
                          itemCount: reprimandApprovals.length,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 10,
                            color: Color(0xffF1FCFF),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final reprimandApproval = reprimandApprovals[index];
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
                                            ReprimandDetailPage(
                                          reprimandId:
                                              reprimandApproval.reprimandId,
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
                                    imageUrl: reprimandApproval
                                        .reprimandProfilePicture!,
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
                                        reprimandApproval
                                            .reprimandDocumentNumber,
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
                                              reprimandApproval
                                                  .reprimandRequesterName!,
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
                                              '${reprimandApproval.reprimandType} - ${reprimandApproval.reprimandNotes}',
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
                                            '${reprimandApproval.reprimandEffectiveDate} - ${reprimandApproval.reprimandExpirationDate} ',
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
