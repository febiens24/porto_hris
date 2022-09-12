import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'core/injector.dart';
import 'hris_apps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  // Uncomment to debug bloc
  // BlocOverrides.runZoned(
  //   () => runApp(
  //     const HRISApps(),
  //   ),
  //   blocObserver: SimpleBlocObserver(),
  // );

  runApp(const HRISApps());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
