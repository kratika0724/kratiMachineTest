import 'package:bloc_demo/bloc/home/home_bloc.dart';
import 'package:bloc_demo/bloc/home/home_event.dart';
import 'package:bloc_demo/bloc/home/second_screen_nav_bloc.dart';
import 'package:bloc_demo/bloc/home/second_screen_nav_event.dart';
import 'package:bloc_demo/bloc/home/second_screen_nav_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GoToSecondScreenBloc, GoToSecondScreenState>(
        listener: (BuildContext context, listener){
          if(listener is InitState){
            Navigator.of(context).pushNamed("SecondScreen");
          }
        },
      child: BlocBuilder<HomeBloc, int>(
        builder: (BuildContext context, int counter) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text("Home"),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                /// Add Event to the bloc
                BlocProvider.of<HomeBloc>(context).add(HomeButtonClickEvent());
              },
              child: const Icon(Icons.add),
            ),
            body: Column(
              children: [
                Center(
                  child: Text(
                    "Clicked this time: $counter",
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<GoToSecondScreenBloc>(context).add(GoToSecondScreenEvent());
                  },
                  child: const Text("Go to next"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
