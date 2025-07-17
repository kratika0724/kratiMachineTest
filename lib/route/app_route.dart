
import 'package:bloc_demo/bloc/home/home_bloc.dart';
import 'package:bloc_demo/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {

  final HomeBloc _homeBloc = HomeBloc();

  Route onGenerateRoute(RouteSettings settings){
    Widget widget;

    switch(settings.name){
      case "/":
       widget = BlocProvider<HomeBloc>.value(
         value: _homeBloc,
         child: const Home(),
       );
      default:
        widget = SizedBox.shrink();
    }
    return MaterialPageRoute(builder: (_) => widget);
  }
}