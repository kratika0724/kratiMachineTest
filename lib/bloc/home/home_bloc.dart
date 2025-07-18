import 'package:bloc/bloc.dart';
import 'package:bloc_demo/bloc/home/home_event.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<HomeEvent, int> {
  HomeBloc() : super(0) {
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
