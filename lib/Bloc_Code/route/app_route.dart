
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/second_screen_nav_bloc.dart';
import '../ui/home/home.dart';
import '../ui/second_screen/second.dart';

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
