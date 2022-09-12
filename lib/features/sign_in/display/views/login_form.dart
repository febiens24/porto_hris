import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../common/utils/color_const.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../bloc/sign_in_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController? _usernameController;
  TextEditingController? _passwordController;
  String _appVersion = '-';

  @override
  void initState() {
    super.initState();
    _init();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  void _init() async {
    final _packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = _packageInfo.version;
    });
  }

  void loginUser(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('either username or password is empty!'),
          ),
        );
    } else {
      BlocProvider.of<SignInBloc>(context).add(
        SignInUser(
          username: username,
          password: password,
        ),
      );
    }
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is SignInComplete) {
          Navigator.pop(context);
          context.read<AuthenticationBloc>().add(
                AuthenticationLogin(state.user),
              );
        } else if (state is SignInFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error.result!),
                backgroundColor: Colors.red,
              ),
            );
        } else if (state is SignInLoading) {
          showAlertDialog(context);
        }
      },
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: sizeHeight / 8),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/img_porto_logo.png',
                    width: 180.w,
                    height: 180.h,
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  const Chip(
                    label: Text(
                      "ONLY FOR EMPLOYEE",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    height: 25.0.h,
                  ),
                  SizedBox(
                    width: 300.0.w,
                    child: TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_pin),
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  SizedBox(
                    width: 300.0.w,
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.0.h,
                  ),
                  SizedBox(
                    width: 300.0.w,
                    height: 50.0.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConst.defaultColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      onPressed: () {
                        loginUser(
                          _usernameController!.text,
                          _passwordController!.text,
                        );
                      },
                      label: const Text("LOGIN"),
                      icon: const Icon(Icons.login_sharp),
                    ),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  SizedBox(
                    width: 300.0.w,
                    height: 50.0.h,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConst.colorBLACK2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const WebViewScreen(
                        //       UrlConstants.urlSupport,
                        //       title: 'Support',
                        //     ),
                        //   ),
                        // );
                      },
                      label: const Text("SUPPORT"),
                      icon: const Icon(Icons.support_agent),
                    ),
                  ),
                  SizedBox(
                    width: 100.0.w,
                    height: 130.0.h,
                    child: Center(
                      child: Text(
                        'Version: $_appVersion',
                        style: TextStyle(
                          color: ColorConst.colorGRAY1,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
