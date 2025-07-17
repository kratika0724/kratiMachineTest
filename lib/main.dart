import 'package:bloc_demo/bloc/home/home_bloc.dart';
import 'package:bloc_demo/route/app_route.dart';
import 'package:bloc_demo/ui/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

   RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoute().onGenerateRoute,
    );
  }
}
