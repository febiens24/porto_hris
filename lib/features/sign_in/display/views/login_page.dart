import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injector.dart';
import '../../../authentication/bloc/authentication_bloc.dart';
import '../bloc/sign_in_bloc.dart';
import 'login_form.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(
          staffSignInUseCase: injector(),
          authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        ),
        child: const LoginForm(),
      ),
    );
  }
}
