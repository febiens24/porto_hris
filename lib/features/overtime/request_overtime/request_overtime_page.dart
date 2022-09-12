import 'dart:io';

import 'package:badges/badges.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../common/utils/color_const.dart';
import '../../widgets/asset_gif_dialog.dart';
import '../../widgets/svg_icon_widget.dart';
import '../../widgets/textbox_widget.dart';
import 'bloc/request_overtime_bloc.dart';

class RequestOvertimePage extends StatelessWidget {
  const RequestOvertimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestOvertimeBloc(),
      child: const RequestOvertimePageView(),
    );
  }
}

class RequestOvertimePageView extends StatefulWidget {
  const RequestOvertimePageView({Key? key}) : super(key: key);

  @override
  State<RequestOvertimePageView> createState() =>
      _RequestOvertimePageViewState();
}

class _RequestOvertimePageViewState extends State<RequestOvertimePageView> {
  //date
  DateTimeRange? dateRange;
  DateTime? startDate;
  DateTime? today = DateTime.now();
  String? startDateString;
  TextEditingController? startDateController;
  TextEditingController? endDateController;
  TextEditingController? differenceDateController;

  //reason
  TextEditingController? _reasonController;

  //attachment

  //leave balance
  dynamic selectedLeaveType;
  int leaveRequested = 0;
  int leaveBalance = 0;
  int remainingBalance = 0;
  int leaveMaximum = 3;
  int pending = 3;

  //submit
  final _formKey = GlobalKey<FormState>();
  bool isButtonActive = true;

  List<PlatformFile>? _paths;
  final List<PlatformFile>? attachment = [];
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

  int remainingBalanceCalculate(int leaveBalance, int leaveRequested) {
    int remainingBalance = leaveBalance - leaveRequested;
    return remainingBalance;
  }

  Future pickDateTimeRange() async {
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
      differenceDateController!.text = duration.toString();
    }
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
        attachment!.addAll(
          _paths!.take(3).where((element) => element.size <= 5242880).where(
                (newItem) => attachment!.every(
                  (attachmentItem) =>
                      newItem != attachmentItem,
                ),
              ),
        );
      }
    });
  }

  final List<Map<String, dynamic>> dataDummy = [
    {
      'LeaveBalanceId': 1,
      'LeaveBalanceName': "Hari kerja",
      'LeaveBalanceData': {
        'LeaveType': "Other",
        'Balance': 10,
        'UsedBalanace': 2,
        'RemainingBalance': 8,
        'CurrentYear': 3,
        'Transfer Quota': 4,
        'TransferQuotaExpiredDaate': 1
      },
    },
    {
      'LeaveBalanceId': 2,
      'LeaveBalanceName': "Hari libur",
      'LeaveBalanceData': {
        'LeaveType': "Other",
        'Balance': 2,
        'UsedBalanace': 2,
        'RemainingBalance': 8,
        'CurrentYear': 3,
        'Transfer Quota': 4,
        'TransferQuotaExpiredDaate': 1
      },
    },
  ];

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
    differenceDateController!.dispose();
    endDateController!.dispose();
    _reasonController!.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    remainingBalance = remainingBalanceCalculate(leaveBalance, leaveRequested);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Request Overtime',
        ),
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
      ),
      body: BlocListener<RequestOvertimeBloc, RequestOvertimeState>(
        listener: (context, state) {
          if (state is SubmitOvertimeLoading) {
            EasyLoading.show(
              status: 'Loading...',
              dismissOnTap: false,
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is SubmitOvertimeSuccess) {
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
                          'Overtime Type',
                          style: textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffADADAD),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        DropdownButtonFormField<Map<String, dynamic>>(
                          // key: _formKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'leaveTypeErr';
                            }
                            return null;
                          },
                          style: textTheme.bodyMedium,
                          hint: const Text('Pilih jenis cuti'),
                          decoration: InputDecoration(
                            hintStyle: textTheme.bodyMedium,
                            filled: true,
                            fillColor: const Color(0xffF2F2F2),
                            isDense: true,
                            // suffixIcon: const Icon(Icons.calendar_today_outlined),
                            // contentPadding:
                            //     EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffF2F2F2),
                              ),
                              borderRadius: BorderRadius.circular(6.0).r,
                            ),
                            // errorBorder: OutlineInputBorder(
                            //   borderSide: const BorderSide(
                            //     color: Color(0xffF2F2F2),
                            //   ),
                            //   borderRadius: BorderRadius.circular(6.0),
                            // ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffF2F2F2),
                              ),
                              borderRadius: BorderRadius.circular(6.0).r,
                            ),
                            // focusedErrorBorder: OutlineInputBorder(
                            //   borderSide: const BorderSide(
                            //     color: Color(0xffF2F2F2),
                            //   ),
                            //   borderRadius: BorderRadius.circular(6.0),
                            // ),
                            // disabledBorder: OutlineInputBorder(
                            //   borderSide: const BorderSide(
                            //     color: Color(0xffF2F2F2),
                            //   ),
                            //   borderRadius: BorderRadius.circular(6.0),
                            // ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: const BorderSide(
                            //     color: Color(0xffF2F2F2),
                            //   ),
                            //   borderRadius: BorderRadius.circular(6.0),
                            // ),
                          ),
                          items: dataDummy.map((e) {
                            return DropdownMenuItem<Map<String, dynamic>>(
                              value: e,
                              child: Text(e['LeaveBalanceName']),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedLeaveType = newValue!;
                              // print(
                              //     "print: ${selectedLeaveType['LeaveBalanceData']['Balance']}");
                              leaveBalance =
                                  selectedLeaveType['LeaveBalanceData']
                                      ['Balance'];
                            });
                          },
                        ),
                        SizedBox(
                          height: 10.h,
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
                      readOnly: true,
                      onTap: () async {
                        // FocusScope.of(context).requestFocus(FocusNode());

                        // final date = await showDatePicker(
                        //   context: context,
                        //   initialDate: DateTime.now(),
                        //   firstDate: DateTime(1900),
                        //   lastDate: DateTime(2100),
                        // );
                        // String formattedDate =
                        //     DateFormat('yyyy-MM-dd').format(date!);
                        // startDateController!.text = formattedDate;
                        pickDateTimeRange();
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextboxWidget(
                      controller: endDateController,
                      label: 'End date',
                      hintText: 'End date',
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
                      label: 'Duration (Hours)',
                      hintText: 'Durations',
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
                              itemCount: attachment!.length + 1,
                              separatorBuilder: (context, index) => SizedBox(
                                width: 11.97.w,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // final file = _paths![index + 1];
                                if (index == attachment!.length) {
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
                                            onPressed: () {
                                              _pickFiles();
                                            },
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
                                        attachment!.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 12.r,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: _fileExt.contains(
                                          attachment![index].extension)
                                      ? SizedBox(
                                          width: 80.h,
                                          height: 80.h,
                                          child: Image.file(
                                            File(attachment![index].path!),
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
                                                attachment![index].name,
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
            onPressed: _onSubmitOvertime,
            style: ElevatedButton.styleFrom(
              primary: ColorConst.defaultColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6).r,
              ),
            ),
            // leaveRequested <= leaveMaximum && !remainingBalance.isNegative
            //     ? () async {
            //         if (_formKey.currentState!.validate()) {
            //           // UploadImageLoading.showLoadingDialog(context);
            //           // List response = await googleService
            //           //     .uploadMultiFileWithoutCompress(fileList);
            //           // if (response.length == fileList.length) {
            //           //   setState(() {
            //           //     //loadingBerhenti
            //           //     Navigator.of(context, rootNavigator: true)
            //           //         .pop();
            //           //   });
            //           //   Navigator.of(context, rootNavigator: true)
            //           //       .pushNamed(AppRouter.success_requesst);
            //           // }
            //         }
            //         setState(() {
            //           isButtonActive = false;
            //         });
            //       }
            //     : null,
            child: Text(
              'SUBMIT REQUEST',
              style: textTheme.button!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void _onOkButtonPressed() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  void _onSubmitOvertime() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      BlocProvider.of<RequestOvertimeBloc>(context).add(SubmitOvertime());
    }
  }
}
