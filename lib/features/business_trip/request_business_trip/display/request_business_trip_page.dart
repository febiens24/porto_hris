import 'dart:convert';
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

import '../../../../common/utils/color_const.dart';
import '../../../../core/global/models/state_model.dart';
import '../../../widgets/asset_gif_dialog.dart';
import '../../../widgets/svg_icon_widget.dart';
import '../../../widgets/textbox_widget.dart';
import '../bloc/request_business_trip_bloc.dart';

class RequestBusinessTripPage extends StatelessWidget {
  const RequestBusinessTripPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestBusinessTripBloc(),
      child: const RequestBusinessTripPageView(),
    );
  }
}

class RequestBusinessTripPageView extends StatefulWidget {
  const RequestBusinessTripPageView({Key? key}) : super(key: key);

  @override
  State<RequestBusinessTripPageView> createState() =>
      _RequestBusinessTripPageViewState();
}

class _RequestBusinessTripPageViewState
    extends State<RequestBusinessTripPageView> {
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

  List<String> cities = ["City"];
  String selectedCity = "City";
  String selectedState = "State/Province";
  List<String> states = ["State/Province"];

  //reason
  TextEditingController? _reasonController;

  late TextEditingController _addressController;

  //attachment

  //leave balance
  var selectedLeaveType;
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

  Future<Map<String, dynamic>> getResponse() async {
    var res = await rootBundle.loadString('assets/states_cities.json');
    return jsonDecode(res);
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = StateModel.fromJson(response).states;
    for (var f in takestate!) {
      if (!mounted) return;
      setState(() {
        states.add(f.name!);
      });
    }
    return states;
  }

  Future getCity(String state) async {
    var response = await getResponse();
    var takeState = StateModel.fromJson(response)
        .states!
        .where((element) => element.name == state)
        .toList();
    for (var item in takeState) {
      if (!mounted) return;
      setState(() {
        var cityName = item.city!.map((e) => e.name).toList();
        for (var name in cityName) {
          cities.add(name!);
        }
      });
    }
    return cities;
  }

  void _onSelectedState(String value) {
    if (!mounted) return;
    setState(() {
      selectedCity = "Choose City";
      cities = ["Choose City"];
      selectedState = value;
      getCity(value);
    });
  }

  void _onSelectedCity(String value) {
    if (!mounted) return;
    setState(() {
      selectedCity = value;
    });
  }

  int getDaysInBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24 + 1).round();
  }

  Future pickDateTimeRange() async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(const Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dateRange ?? initialDateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      if (dateRange != null) {
        startDateController!.text =
            DateFormat('dd/MM/yyyy').format(dateRange!.start);
        endDateController!.text =
            DateFormat('dd/MM/yyyy').format(dateRange!.end);
        // workDateController
        // ..text = DateFormat('dd/MM/yyyy').format(dateRange!.);
        var temp = getDaysInBetween(dateRange!.start, dateRange!.end);
        leaveRequested = temp;
        differenceDateController!.text = temp.toString();
        // print(differenceDateController);
      }
    });
  }

  int remainingBalanceCalculate(int leaveBalance, int leaveRequested) {
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

  final List<Map<String, dynamic>> dataDummy = [
    {
      'LeaveBalanceId': 1,
      'LeaveBalanceName': "Indonesia",
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
  ];

  @override
  void initState() {
    super.initState();

    startDateController = TextEditingController();
    endDateController = TextEditingController();
    differenceDateController = TextEditingController();

    _reasonController = TextEditingController();

    _addressController = TextEditingController();

    _reasonController!.addListener(() {
      final isButtonActive = _reasonController!.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    getState();
  }

  @override
  void dispose() {
    _reasonController!.dispose();
    startDateController!.dispose();
    endDateController!.dispose();
    differenceDateController!.dispose();
    _reasonController!.removeListener(() {});
    _addressController.dispose();
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
          'Request Business Trip',
        ),
        backgroundColor: ColorConst.defaultColor,
        centerTitle: true,
      ),
      body: BlocListener<RequestBusinessTripBloc, RequestBusinessTripState>(
        listener: (context, state) {
          if (state is SubmitBusinessTripLoading) {
            EasyLoading.show(
              status: 'Loading...',
              dismissOnTap: false,
              maskType: EasyLoadingMaskType.black,
            );
          } else if (state is SubmitBusinessTripSuccess) {
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
                          'Kegiatan',
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
                          style: textTheme.bodyMedium!,
                          hint: const Text('Pilih jenis kegiatan'),
                          decoration: InputDecoration(
                            hintStyle: textTheme.bodyMedium!,
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
                          ),
                          items: dataDummy.map((e) {
                            return DropdownMenuItem<Map<String, dynamic>>(
                              child: Text(e['LeaveBalanceName']),
                              value: e,
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
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // TextboxWidget(
                    //   controller: startDateController,
                    //   label: 'Alamat',
                    //   hintText: 'Input alamat disini',
                    //   prefixIcon: SvgIcon(
                    //     path: 'assets/icons/ic_start_date.svg',
                    //     width: 24.h,
                    //     height: 24.h,
                    //     color: ColorConst.defaultColor,
                    //   ),
                    // ),
                    TextboxWidget(
                      controller: _addressController,
                      label: 'Alamat',
                      hintText: 'Tulis alamat disini',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter alamat';
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
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Negara',
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
                          style: textTheme.bodyMedium!,
                          hint: const Text('Pilih negara'),
                          decoration: InputDecoration(
                            hintStyle: textTheme.bodyMedium!,

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
                              child: Text(e['LeaveBalanceName']),
                              value: e,
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
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Provinsi',
                          style: textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffADADAD),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        DropdownButtonFormField<String>(
                          // key: _formKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'leaveTypeErr';
                            }
                            return null;
                          },
                          style: textTheme.bodyMedium!,
                          hint: const Text('Pilih provinsi'),
                          decoration: InputDecoration(
                            hintStyle: textTheme.bodyMedium!,

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
                          ),
                          items: states.map((e) {
                            return DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (newValue) => _onSelectedState(newValue!),
                          value: selectedState,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kota',
                          style: textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffADADAD),
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        DropdownButtonFormField<String>(
                          // key: _formKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'leaveTypeErr';
                            }
                            return null;
                          },
                          hint: const Text('Pilih kota'),
                          style: textTheme.bodyMedium!,
                          decoration: InputDecoration(
                            hintStyle: textTheme.bodyMedium!,
                            filled: true,
                            fillColor: const Color(0xffF2F2F2),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffF2F2F2),
                              ),
                              borderRadius: BorderRadius.circular(6.0).r,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffF2F2F2),
                              ),
                              borderRadius: BorderRadius.circular(6.0).r,
                            ),
                          ),
                          items: cities.map((e) {
                            return DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (newValue) => _onSelectedCity(newValue!),
                          value: selectedCity,
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
                      label: 'Duration',
                      hintText: 'Durations (Day)',
                      prefixIcon: SvgIcon(
                        path: 'assets/icons/ic_duration.svg',
                        width: 24.h,
                        height: 24.h,
                        color: ColorConst.defaultColor,
                      ),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 20.h,
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
                      height: 20.h,
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
                            height: 6.h,
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
            onPressed: _submitBusinessTrip,
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

  void _submitBusinessTrip() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      BlocProvider.of<RequestBusinessTripBloc>(context)
          .add(SubmitBusinessTrip());
    }
  }

  void _onOkButtonPressed() {
    Navigator.of(context)
      ..pop()
      ..pop();
  }
}
