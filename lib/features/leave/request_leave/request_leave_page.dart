import 'dart:io';

import 'package:badges/badges.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../common/utils/color_const.dart';
import '../../../core/injector.dart';
import '../../widgets/asset_gif_dialog.dart';
import '../../widgets/svg_icon_widget.dart';
import '../../widgets/textbox_widget.dart';
import '../domain/entities/leave_types_entity.dart';
import '../leave_detail/leave_detail_page.dart';
import 'bloc/leave_request_bloc.dart';

class RequestLeavePage extends StatelessWidget {
  const RequestLeavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeaveRequestBloc(
        getLeaveTypes: injector(),
      )..add(LoadLeaveTypes()),
      child: const RequestLeavePageView(),
    );
  }
}

class RequestLeavePageView extends StatefulWidget {
  const RequestLeavePageView({Key? key}) : super(key: key);

  @override
  State<RequestLeavePageView> createState() => _RequestLeavePageViewState();
}

class _RequestLeavePageViewState extends State<RequestLeavePageView> {
  bool isChecked = false;
  //date
  DateTimeRange? dateRange;
  DateTimeRangePicker? dateTimeRangePicker;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? today = DateTime.now();
  String? startDateString;
  TextEditingController? startDateController;
  TextEditingController? endDateController;
  TextEditingController? differenceDateController;

  //reason
  TextEditingController? _reasonController;

  //attachment

  //leave balance
  LeaveTypeResultEntity? selectedLeaveType;
  int leaveRequested = 0;
  int leaveBalance = 0;
  int remainingBalance = 0;
  int leaveMaximum = 3;
  int pending = 3;

  //submit
  final _formKey = GlobalKey<FormState>();
  bool isButtonActive = true;

  List<PlatformFile>? _paths;
  final List<PlatformFile>? _attachment = [];
  // String? _extension;
  final FileType _pickingType = FileType.custom;

  final List<String> _fileExt = [
    'apng',
    'avif',
    'gif',
    'jpg',
    'jpeg',
    'jfif',
    'pjpeg',
    'pjp',
    'png',
    'svg',
    'webp',
    'bmp',
    'ico',
    'cur',
    'tif',
    'tiff',
  ];

  int getDaysInBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24 + 1).round();
  }

  void pickDateTimeRange() async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dateRange ?? initialDateRange);

    if (newDateRange == null) return;

    dateRange = newDateRange;
    if (dateRange != null) {
      startDateController!.text =
          DateFormat('dd/MM/yyyy').format(dateRange!.start);
      endDateController!.text = DateFormat('dd/MM/yyyy').format(dateRange!.end);
      // workDateController
      // ..text = DateFormat('dd/MM/yyyy').format(dateRange!.);
      var duration = getDaysInBetween(dateRange!.start, dateRange!.end);
      setState(() {
        leaveRequested = duration;
      });
      differenceDateController!.text = '$duration Hari';
    }
  }

  int calculateRemainingLeaveBalance(int leaveBalance, int leaveRequested) {
    int remainingBalance = leaveBalance - leaveRequested;
    return remainingBalance;
  }

  void _pickFiles() async {
    // _resetState();
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: [
          'jpg',
          'pdf',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'png',
          'jpeg',
          'bmp',
          'ppt',
          'pptx',
          'txt'
        ],
      ))
          ?.files;
    } on PlatformException {
      // _logException('Unsupported operation' + e.toString());
    } catch (e) {
      // _logException(e.toString());
    }
    if (!mounted) return;
    // setState(() {
    //   _isLoading = false;
    //   _fileName =
    //       _paths != null ? _paths!.map((e) => e.name).toString() : '...';
    //   _userAborted = _paths == null;
    // });
    if (_paths == null) {
      return;
    }
    setState(() {
      if (_paths != null) {
        _attachment!.addAll(
          _paths!.take(3).where((element) => element.size <= 5242880).where(
                (newItem) => _attachment!.every(
                  (attachmentItem) =>
                      newItem != attachmentItem,
                ),
              ),
        );
      }
    });
  }

  // final List<Map<String, dynamic>> dataDummy = [
  //   {
  //     'LeaveBalanceId': 1,
  //     'LeaveBalanceName': "Bencanca Alam / Force Majeur",
  //     'LeaveBalanceData': {
  //       'LeaveType': "Other",
  //       'Balance': 10,
  //       'UsedBalanace': 2,
  //       'RemainingBalance': 8,
  //       'CurrentYear': 3,
  //       'Transfer Quota': 4,
  //       'TransferQuotaExpiredDaate': 1
  //     },
  //   },
  //   {
  //     'LeaveBalanceId': 2,
  //     'LeaveBalanceName':
  //         "Kematian anak, suami, istri, orang tua, mertua/menantu karyawan(dalam satu rumah)",
  //     'LeaveBalanceData': {
  //       'LeaveType': "Other",
  //       'Balance': 2,
  //       'UsedBalanace': 2,
  //       'RemainingBalance': 8,
  //       'CurrentYear': 3,
  //       'Transfer Quota': 4,
  //       'TransferQuotaExpiredDaate': 1
  //     },
  //   },
  //   {
  //     'LeaveBalanceId': 3,
  //     'LeaveBalanceName':
  //         "Bencana alam banjir, kebakaran, dan bencana alam lainnya",
  //     'LeaveBalanceData': {
  //       'LeaveType': "Other",
  //       'Balance': 3,
  //       'UsedBalanace': 2,
  //       'RemainingBalance': 8,
  //       'CurrentYear': 3,
  //       'Transfer Quota': 4,
  //       'TransferQuotaExpiredDaate': 1
  //     },
  //   },
  // ];

  @override
  void initState() {
    super.initState();

    startDateController = TextEditingController();
    endDateController = TextEditingController();
    differenceDateController = TextEditingController();

    _reasonController = TextEditingController();

    _reasonController!.addListener(() {
      final isButtonActive = _reasonController!.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
  }

  @override
  void dispose() {
    _reasonController!.dispose();
    startDateController!.dispose();
    endDateController!.dispose();
    differenceDateController!.dispose();
    _reasonController!.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    remainingBalance =
        calculateRemainingLeaveBalance(leaveBalance, leaveRequested);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Request Leave',
        ),
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
      ),
      body: BlocListener<LeaveRequestBloc, LeaveRequestState>(
        listener: (context, state) {
          if (state is SubmitLeaveLoading) {
            EasyLoading.show(
              status: 'Loading...',
              dismissOnTap: false,
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is SubmitLeaveSuccess) {
            EasyLoading.dismiss();

            showDialog(
              context: context,
              builder: (context) {
                return AssetGiffyDialog(
                  image: Image.asset(
                    'assets/images/success.gif',
                    fit: BoxFit.cover,
                  ),
                  title: const Text(
                    'Success!',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                  description: const Text(
                    'Pengajuan cuti Anda berhasil diterima, silahkan menunggu persetujuan dari atasan langsung',
                    textAlign: TextAlign.center,
                  ),
                  onOkButtonPressed: _onOkButtonPressed,
                  onlyOkButton: true,
                );
              },
            );
          }
        },
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20).r,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Leave Type',
                          style: textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffADADAD),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        // DropdownButtonFormField<Map<String, dynamic>>(
                        //   isExpanded: true,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'leaveTypeErr';
                        //     }
                        //     return null;
                        //   },
                        //   hint: Text(
                        //     'Pilih jenis cuti',
                        //     style: textTheme.bodyMedium,
                        //   ),
                        //   style: textTheme.bodyMedium,
                        //   decoration: InputDecoration(
                        //     hintStyle: textTheme.bodyMedium,
                        //     filled: true,
                        //     fillColor: const Color(0xffF2F2F2),
                        //     isDense: true,
                        //     border: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //         color: Color(0xffF2F2F2),
                        //       ),
                        //       borderRadius: BorderRadius.circular(6.0).r,
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: const BorderSide(
                        //         color: Color(0xffF2F2F2),
                        //       ),
                        //       borderRadius: BorderRadius.circular(6.0).r,
                        //     ),
                        //   ),
                        //   items: dataDummy.map((e) {
                        //     return DropdownMenuItem<Map<String, dynamic>>(
                        //       child: Text(
                        //         e['LeaveBalanceName'],
                        //         overflow: TextOverflow.ellipsis,
                        //       ),
                        //       value: e,
                        //     );
                        //   }).toList(),
                        //   onChanged: (newValue) {
                        //     setState(() {
                        //       selectedLeaveType = newValue!;
                        //       leaveBalance = selectedLeaveType['LeaveBalanceData']
                        //           ['Balance'];
                        //     });
                        //   },
                        // ),
                        // CheckboxListTile(
                        //   title: Text(
                        //     'Half-day',
                        //     style: textTheme.bodyMedium!.copyWith(
                        //       color: const Color(0xffADADAD),
                        //     ),
                        //   ),
                        //   contentPadding: EdgeInsets.zero,
                        //   checkColor: Colors.white,
                        //   value: isChecked,
                        //   onChanged: (bool? value) {
                        //     setState(() {
                        //       isChecked = value!;
                        //     });
                        //   },
                        // ),
                        BlocBuilder<LeaveRequestBloc, LeaveRequestState>(
                          builder: (context, state) {
                            if (state is LeaveTypesLoadInProgress) {
                              return const ShimmerLoadingData();
                            } else if (state is LeaveTypesLoadSuccess) {
                              return Column(
                                children: [
                                  DropdownButtonFormField<
                                      LeaveTypeResultEntity>(
                                    isExpanded: true,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'leaveTypeErr';
                                      }
                                      return null;
                                    },
                                    hint: Text(
                                      'Pilih jenis cuti',
                                      style: textTheme.bodyMedium,
                                    ),
                                    style: textTheme.bodyMedium,
                                    decoration: InputDecoration(
                                      hintStyle: textTheme.bodyMedium,
                                      filled: true,
                                      fillColor: const Color(0xffF2F2F2),
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xffF2F2F2),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(6.0).r,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color(0xffF2F2F2),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(6.0).r,
                                      ),
                                    ),
                                    items: state.leaveTypes.result.map((e) {
                                      return DropdownMenuItem<
                                          LeaveTypeResultEntity>(
                                        child: Text(
                                          e.leaveType,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        value: e,
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedLeaveType = newValue!;
                                        // leaveBalance =
                                        //     selectedLeaveType['LeaveBalanceData']
                                        //         ['Balance'];
                                      });
                                    },
                                  ),
                                  selectedLeaveType != null
                                      ? selectedLeaveType!.isHalfdayAllowed
                                          ? CheckboxListTile(
                                              title: Text(
                                                'Half-day',
                                                style: textTheme.bodyMedium!
                                                    .copyWith(
                                                  color:
                                                      const Color(0xffADADAD),
                                                ),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              checkColor: Colors.white,
                                              value: isChecked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isChecked = value!;
                                                });
                                              },
                                            )
                                          : const SizedBox(height: 15)
                                      : const SizedBox(height: 15),
                                ],
                              );
                            } else {
                              return const ShimmerLoadingData();
                            }
                          },
                        ),
                        SimpleShadow(
                          opacity: 0.2, // Default: 0.5
                          sigma: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5).r,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0).r,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ).r,
                                height: 72.h,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Leave balance',
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          leaveBalance.toString(),
                                          style: textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Leave requested',
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          leaveRequested > leaveMaximum
                                              ? 'Max request'
                                              : leaveRequested.toString(),
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: leaveRequested > leaveMaximum
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Remaining balance',
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          leaveRequested > leaveMaximum
                                              ? 'Cant calculate'
                                              : remainingBalance.isNegative
                                                  ? 'Quota not enough'
                                                  : remainingBalance.toString(),
                                          // style: TextStyle(
                                          //   color: remainingBalanceCalculate(
                                          //                   leaveBalance,
                                          //                   leaveRequested)
                                          //               .isNegative ||
                                          //           leaveRequested > leaveMaximum
                                          //       ? Colors.red
                                          //       : Colors.black,
                                          // ),
                                          style: textTheme.bodyMedium!.copyWith(
                                            color:
                                                calculateRemainingLeaveBalance(
                                                                leaveBalance,
                                                                leaveRequested)
                                                            .isNegative ||
                                                        leaveRequested >
                                                            leaveMaximum
                                                    ? Colors.red
                                                    : Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(
                                    //   height: 15,
                                    // ),
                                    // RichText(
                                    //     text: TextSpan(
                                    //         text: 'You can only request for',
                                    //         style: const TextStyle(color: Colors.black),
                                    //         children: [
                                    //       const TextSpan(
                                    //         text: " ",
                                    //       ),
                                    //       TextSpan(
                                    //           text: leaveMaximum.toString(),
                                    //           style: const TextStyle(
                                    //               fontWeight: FontWeight.bold)),
                                    //       const TextSpan(
                                    //         text: " ",
                                    //       ),
                                    //       const TextSpan(
                                    //         text: 'hari',
                                    //         style: TextStyle(color: Colors.black),
                                    //       )
                                    //     ]))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextboxWidget(
                      controller: startDateController,
                      label: 'Start date',
                      hintText: 'Start date',
                      prefixIcon: SvgIcon(
                        path: 'assets/icons/ic_start_date.svg',
                        width: 24.h,
                        height: 24.h,
                        color: ColorConst.defaultColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start date';
                        }
                        return null;
                      },
                      readOnly: true,
                      onTap: pickDateTimeRange,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextboxWidget(
                      controller: endDateController,
                      label: 'End date',
                      hintText: 'End date',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start date';
                        }
                        return null;
                      },
                      prefixIcon: SvgIcon(
                        path: 'assets/icons/ic_end_date.svg',
                        width: 24.h,
                        height: 24.h,
                        color: ColorConst.defaultColor,
                      ),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextboxWidget(
                      controller: differenceDateController,
                      label: 'Duration',
                      hintText: 'Durations (Day)',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start date';
                        }
                        return null;
                      },
                      prefixIcon: SvgIcon(
                        path: 'assets/icons/ic_duration.svg',
                        width: 24.h,
                        height: 24.h,
                        color: ColorConst.defaultColor,
                      ),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextboxWidget(
                      controller: _reasonController,
                      label: 'Catatan',
                      hintText: 'Tulis catatan disini',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter start date';
                        }
                        return null;
                      },
                      prefixIcon: SvgIcon(
                        path: 'assets/icons/ic_notes.svg',
                        width: 24.h,
                        height: 24.h,
                        color: ColorConst.defaultColor,
                      ),
                      readOnly: false,
                      maxLines: 5,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Attachments',
                            style: textTheme.bodyMedium!.copyWith(
                              color: const Color(0xffADADAD),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 100.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _attachment!.length + 1,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 11.97.w,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // final file = _paths![index + 1];
                                if (index == _attachment!.length) {
                                  return index < 3
                                      ? Container(
                                          height: 100.h,
                                          width: 100.h,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorConst.cardColor,
                                                spreadRadius: 1,
                                                blurRadius: 8,
                                                offset: const Offset(0, 0),
                                              )
                                            ],
                                          ),
                                          child: ElevatedButton(
                                            onPressed: _pickFiles,
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: BorderSide(
                                                  color:
                                                      ColorConst.defaultColor,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgIcon(
                                                  path:
                                                      'assets/icons/ic_attachment.svg',
                                                  width: 32.h,
                                                  height: 32.h,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  'Attachment',
                                                  style: textTheme.caption,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }
                                return Badge(
                                  padding: const EdgeInsets.all(5).r,
                                  toAnimate: false,
                                  badgeContent: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _attachment!.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 12.r,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: _fileExt.contains(
                                          _attachment![index].extension)
                                      ? SizedBox(
                                          width: 80.h,
                                          height: 80.h,
                                          child: Image.file(
                                            File(_attachment![index].path!),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SizedBox(
                                          height: 80.h,
                                          width: 80.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SvgIcon(
                                                path:
                                                    'assets/icons/ic_file.svg',
                                                width: 58.h,
                                                height: 58.h,
                                              ),
                                              Text(
                                                _attachment![index].name,
                                                style: textTheme.caption,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Container(
          padding: const EdgeInsets.all(5).r,
          child: ElevatedButton(
            onPressed: _submitRequest,
            child: Text(
              'SUBMIT REQUEST',
              style: textTheme.button!.copyWith(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: ColorConst.defaultColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6).r,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      BlocProvider.of<LeaveRequestBloc>(context).add(SubmitRequest());
    }
  }

  void _onOkButtonPressed() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }
}
