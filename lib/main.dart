import 'package:bloc_demo/bloc/home/home_bloc.dart';
import 'package:bloc_demo/bloc/home/second_screen_nav_bloc.dart';
import 'package:bloc_demo/route/app_route.dart';
import 'package:bloc_demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => GoToSecondScreenBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        onGenerateRoute: AppRoute().onGenerateRoute,
      ),
    );
  }
}
