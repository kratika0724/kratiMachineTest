
import 'package:bloc_demo/bloc/home/home_bloc.dart';
import 'package:bloc_demo/bloc/home/home_event.dart';
import 'package:bloc_demo/bloc/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, listener){
        if(listener is SuccessState){
          print("State Listen");
        }
      },
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Home"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              /// Add Event to the bloc
              BlocProvider.of<HomeBloc>(context).add(HomeButtonClickEvent());
            },
            child: const Icon(Icons.add),
          ),
        );
      }
    );
  }
}
