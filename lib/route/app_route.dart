import 'package:bloc_demo/bloc/home/home_bloc.dart';
import 'package:bloc_demo/bloc/home/second_screen_nav_bloc.dart';
import 'package:bloc_demo/bloc/home/second_screen_nav_state.dart';
import 'package:bloc_demo/ui/home/home.dart';
import 'package:bloc_demo/ui/second_screen/second.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  final GoToSecondScreenBloc _homeNavigateBloc = GoToSecondScreenBloc();

  Route onGenerateRoute(RouteSettings settings, HomeBloc homeBloc) {
    Widget widget;

    switch (settings.name) {
      case "/":
        widget = BlocProvider<HomeBloc>.value(
          value: homeBloc,
          child: const Home(),
        );
        break;
      case "SecondScreen":
        widget = BlocProvider<GoToSecondScreenBloc>.value(
          value: _homeNavigateBloc,
          child: const Second(),
        );
      default:
        widget = const SizedBox.shrink();
    }
    return MaterialPageRoute(builder: (_) => widget);
  }
}
