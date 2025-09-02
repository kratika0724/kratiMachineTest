import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second screen"),
      ),
      body: BlocBuilder<HomeBloc, int>(
        builder: (BuildContext context, int counter) {
          return Column(
            children: [
              Center(
                child: Text(
                  "Clicked this time: $counter",
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  /// Add Event to the bloc
                  BlocProvider.of<HomeBloc>(context).add(HomeButtonClickEvent());
                },
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
      ),
    );
  }
}
