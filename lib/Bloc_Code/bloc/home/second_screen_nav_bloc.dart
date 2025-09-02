import 'package:bloc_demo/Bloc_Code/bloc/home/second_screen_nav_event.dart';
import 'package:bloc_demo/Bloc_Code/bloc/home/second_screen_nav_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class GoToSecondScreenBloc extends Bloc<GoToSecondEvent, GoToSecondScreenState> {
  GoToSecondScreenBloc() : super(InitState()) {
    on<GoToSecondScreenEvent>(
      (handler, emit) {
        emit(InitState());
      },
    );
  }
}
