import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, int> {
  HomeBloc(super.initialState) {
    on<HomeEvent>(
      (handler, emit) async {
        debugPrint("Home Init Event called");
      },
    );
    on<HomeButtonClickEvent>(
      (handler, emit) async {
        emit(state + 1);
      },
    );
  }
}
