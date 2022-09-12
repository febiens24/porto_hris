import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

import '../../../common/utils/color_const.dart';
import '../../../core/date_formatter.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dataSet = [
      {
        "time": "2022-08-26T19:22:09.1440844Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-29T19:22:09.1440844Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-29T10:29:35.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Business Trip"
      },
      {
        "time": "2022-03-28T10:31:12.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-27T10:29:35.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Business Trip"
      },
      {
        "time": "2022-03-28T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Attendance"
      },
      {
        "time": "2022-03-29T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-26T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-27T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-28T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-29T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-28T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
      {
        "time": "2022-03-28T09:41:18.000Z",
        "message":
            "Your request has been Approved ! Click to check the details",
        "tipe": "Leave"
      },
    ];

    var groupByDate =
        groupBy(dataSet, (Map obj) => obj['time'].substring(0, 10));
    // groupByDate.forEach((date, list) {
    //   // Header
    //   print('$date:');

    //   // Group
    //   for (var listItem in list) {
    //     // List item
    //     print('${listItem["time"]}, ${listItem["message"]}');
    //   }
    //   // day section divider
    //   print('\n');
    // });

    // Widget _itemBuilder(IndexPath index) {
    //   return ListTile(
    //     leading: Image.asset(
    //       'assets/icons/ic_notification.png',
    //       width: 42,
    //       height: 42,
    //     ),
    //     title: Text(
    //       groupByDate.values.toList()[index.section][index.index]['message'],
    //     ),
    //     subtitle: Text(
    //       '2 min ago • ${groupByDate.values.toList()[index.section][index.index]['tipe']}',
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.defaultColor,
        title: const Text(
          'Notification',
        ),
      ),
      body: GroupListView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        separatorBuilder: (context, index) {
          return index.index ==
                  groupByDate.values.toList()[index.section].length - 1
              ? const SizedBox.shrink()
              : const Divider();
        },
        sectionSeparatorBuilder: (context, section) =>
            const SizedBox(height: 30),
        itemBuilder: (context, index) {
          return ItemWidget(
            groupByDate: groupByDate,
            index: index,
          );
        },
        sectionsCount: groupByDate.keys.length,
        groupHeaderBuilder: (context, index) {
          String dateTime = groupByDate.keys.toList()[index];
          DateTime parsedDateTime = DateTime.parse(dateTime);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              DateFormatter.getVerboseDateTimeRepresentation(parsedDateTime),
              style: const TextStyle(
                color: Color(0xff696969),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
        countOfItemInSection: (section) {
          return groupByDate.values.toList()[section].length;
        },
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.groupByDate,
    required this.index,
  }) : super(key: key);

  final Map<dynamic, List<Map<String, dynamic>>> groupByDate;
  final IndexPath index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        'assets/icons/ic_notification.png',
        width: 42,
        height: 42,
      ),
      title: Text(
        groupByDate.values.toList()[index.section][index.index]['message'],
      ),
      subtitle: Text(
        '2 min ago • ${groupByDate.values.toList()[index.section][index.index]['tipe']}',
      ),
    );
  }
}
