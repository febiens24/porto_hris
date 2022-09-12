import 'package:flutter/material.dart';
import 'package:hris_project/common/utils/font_const.dart';
import 'package:hris_project/common/utils/spacer_const.dart';
import 'package:hris_project/features/accountWebView/display/account_web_view.dart';
import '../../../common/utils/color_const.dart';
import '../../widgets/dashed_line.dart';

class AkunPage extends StatefulWidget {
  final String bahasa;
  const AkunPage({Key? key, required this.bahasa}) : super(key: key);

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Akun"),
        centerTitle: true,
        backgroundColor: ColorConst.defaultColor,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountProfile(size: size),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Informasi',
                  style: FontConst.boldBlack16,
                ),
                vertikalSpace15,
                IconTextArrowForward(
                  icon: 'assets/icons/ic_about_company.png',
                  textIcon: 'About Company',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountWebView(
                                  title: 'About Company',
                                )));
                  },
                ),
                vertikalSpace10,
                IconTextArrowForward(
                  icon: 'assets/icons/ic_contact_us.png',
                  textIcon: 'Contact Us',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountWebView(
                                  title: 'Contact Us',
                                )));
                  },
                ),
                vertikalSpace10,
                IconTextArrowForward(
                  icon: 'assets/icons/ic_t_and_c.png',
                  textIcon: 'Term and Condition',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountWebView(
                                  title: 'Term and Condition',
                                )));
                  },
                ),
                vertikalSpace10,
                IconTextArrowForward(
                  icon: 'assets/icons/ic_privacy_policy.png',
                  textIcon: 'Privacy and Policy',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountWebView(
                                  title: 'Privacy and Policy',
                                )));
                  },
                ),
                vertikalSpace10,
                IconTextArrowForward(
                  icon: 'assets/icons/ic_faq.png',
                  textIcon: 'FAQ',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountWebView(
                                  title: 'FAQ',
                                )));
                  },
                ),
                vertikalSpace10,
                IconTextArrowForward(
                  icon: 'assets/icons/ic_app_info.png',
                  textIcon: 'Apps Information',
                  pressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountWebView(
                                  title: 'Apps Information',
                                )));
                  },
                ),
                vertikalSpace15,
                Text(
                  'Pengaturan',
                  style: FontConst.boldBlack16,
                ),
                vertikalSpace15,
                TextArrowForward(
                  text: 'Ubah Bahasa',
                  pressed: () {
                    //       List<AlertDialogAction<LanguageEntity>> items = [];
                    //   for (var item in Languages.languages) {
                    //     items.add(
                    //       AlertDialogAction(
                    //         label: item.value,
                    //         key: item,
                    //       ),
                    //     );
                    //   }
                    //   showConfirmationDialog<LanguageEntity>(
                    //     barrierDismissible: false,
                    //     context: context,
                    //     title: TranslationConstants.changeLanguage.t(context),
                    //     actions: items,
                    //     initialSelectedActionKey: Languages.languages
                    //         .firstWhere((e) => e.code == widget.bahasa),
                    //   ).then((value) {
                    //     if (value != null) {
                    //       context.read<LanguageBloc>().add(LanguageChanged(value));
                    //     }
                    //   });
                    // },
                  },
                ),
                vertikalSpace10,
                TextArrowForward(
                  text: 'Logout',
                  pressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountProfile extends StatelessWidget {
  const AccountProfile({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: size.height * 0.17,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConst.defaultColor,
              ),
              height: 40,
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            left: 20,
            child: Card(
              child: SizedBox(
                height: 115,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 16.395,
                            child: Material(
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18.74,
                                  color: ColorConst.defaultColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        radius: 38.0,
                        backgroundImage: const NetworkImage(
                          'https://c.tenor.com/WM0Ji8E27KYAAAAM/scary.gif',
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Linus Trovarl',
                          style: FontConst.boldBlack18,
                        ),
                        Text(
                          'IT Department',
                          style: FontConst.regularDefaultBlack12,
                        ),
                        vertikalSpace10,
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: const DashedLine(),
                        ),
                        vertikalSpace10,
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/ic_mail.png',
                              height: 13,
                              width: 13,
                            ),
                            horizontalSpace10,
                            Text(
                              'user_testing@porto.co.id',
                              style: FontConst.regularDefaultBlack12,
                            ),
                          ],
                        ),
                        vertikalSpace5,
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/ic_telp.png',
                              height: 13,
                              width: 13,
                            ),
                            horizontalSpace10,
                            Text(
                              '081745896523',
                              style: FontConst.regularDefaultBlack12,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextArrowForward extends StatelessWidget {
  const TextArrowForward({
    Key? key,
    required this.text,
    required this.pressed,
  }) : super(key: key);
  final String text;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: FontConst.regularDefaultBlack14,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 20,
          )
        ],
      ),
    );
  }
}

class IconTextArrowForward extends StatelessWidget {
  const IconTextArrowForward({
    Key? key,
    required this.icon,
    required this.textIcon,
    required this.pressed,
  }) : super(
          key: key,
        );
  final String icon;
  final String textIcon;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                height: 25,
                width: 25,
              ),
              horizontalSpace15,
              Text(
                textIcon,
                style: FontConst.regularDefaultBlack14,
              )
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 20,
          )
        ],
      ),
    );
  }
}



// _appBar(height) {
//   return PreferredSize(
//     preferredSize: Size(MediaQuery.of(context).size.width, height + 360),
//     child: Stack(
//       children: <Widget>[
//         Container(
//           // Background
//           child: const Center(
//             child: Text(
//               "Akun",
//               style: TextStyle(
//                   fontSize: 25.0,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white),
//             ),
//           ),
//           color: Theme.of(context).primaryColor,
//           height: height + 75,
//           width: MediaQuery.of(context).size.width,
//         ),
//         Container(),
//         Positioned(
//           top: 100.0,
//           left: 20.0,
//           right: 20.0,
//           child: AppBar(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             toolbarHeight: 115,
//             backgroundColor: Colors.white,
//             primary: false,
//             title: SizedBox(
//               height: 115,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CircleAvatar(
//                     radius: 35,
//                     backgroundColor: Colors.white,
//                     child: CircleAvatar(
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           radius: 16.395,
//                           child: Material(
//                             child: InkWell(
//                               onTap: () {
//                                 print('x');
//                               },
//                               child: const Icon(
//                                 Icons.camera_alt,
//                                 size: 18.74,
//                                 color: Color(0xFF404040),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       radius: 38.0,
//                       backgroundImage: const NetworkImage(
//                         'https://images.viacbs.tech/uri/mgid:arc:imageassetref:nick.com:9cd2df6e-63c7-43da-8bde-8d77af9169c7?quality=0.7',
//                       ),
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'User Testing',
//                         style: TextStyle(
//                           color: Color(0xff282828),
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(
//                         'IT Department',
//                         style: TextStyle(
//                           color: Color(0xff282828),
//                           fontWeight: FontWeight.normal,
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 2,
//                         child: DashedLine(),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/icons/ic_mail.png',
//                             height: 13,
//                             width: 13,
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             'user_testing@porto.co.id',
//                             style: TextStyle(
//                               color: Color(0xff282828),
//                               fontWeight: FontWeight.normal,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/icons/ic_telp.png',
//                             height: 13,
//                             width: 13,
//                           ),
//                           SizedBox(
//                             width: 8,
//                           ),
//                           Text(
//                             '081745896523',
//                             style: TextStyle(
//                               color: Color(0xff282828),
//                               fontWeight: FontWeight.normal,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
