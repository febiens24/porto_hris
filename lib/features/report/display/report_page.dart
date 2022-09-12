import 'package:flutter/material.dart';

import '../../view_schedule_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          backgroundColor: const Color(0xff5991FF),
          centerTitle: true,
          title: const Text(
            'Report',
            style: TextStyle(color: Colors.black),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img_report.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              ReportMenuWidget(
                imagePath: 'assets/icons/ic_report_attendance.png',
                label: 'Attendance',
              ),
              ReportMenuWidget(
                imagePath: 'assets/icons/ic_report_payslip_list.png',
                label: 'Payslip List',
              ),
              ReportMenuWidget(
                imagePath: 'assets/icons/ic_report_career_transition.png',
                label: 'Career Transition',
              ),
              ReportMenuWidget(
                imagePath: 'assets/icons/ic_report_leave_balance.png',
                label: 'Leave Balance',
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ReportMenuWidget(
                imagePath: 'assets/icons/ic_report_view_schedule.png',
                label: 'View Schedule',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewSchedulePage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 65,
              ),
              const SizedBox(
                width: 65,
              ),
              const SizedBox(
                width: 65,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            thickness: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Personal Document',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ReportMenuWidget(
                    imagePath: 'assets/icons/ic_report_documents.png',
                    label: 'Documents',
                  ),
                  ReportMenuWidget(
                    imagePath: 'assets/icons/ic_report_contract.png',
                    label: 'Contract',
                  ),
                  SizedBox(
                    width: 65,
                  ),
                  SizedBox(
                    width: 65,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ReportMenuWidget extends StatelessWidget {
  const ReportMenuWidget({
    Key? key,
    required this.imagePath,
    required this.label,
    this.onTap,
  }) : super(key: key);

  final String imagePath;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 65,
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 54,
                height: 54,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
