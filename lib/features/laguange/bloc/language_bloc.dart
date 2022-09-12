import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hris_project/common/utils/language_const.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
