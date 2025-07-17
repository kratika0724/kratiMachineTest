import 'package:bloc/bloc.dart';
import 'package:bloc_demo/bloc/home/home_event.dart';
import 'package:bloc_demo/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitState()) {
    on<HomeEvent>(
      (handler, emit) async {
        print("Home Init Event called");
      },
    );

    on<HomeButtonClickEvent>(
      (handler, emit) async {
        print("Home Button Click Event called");
        emit(SuccessState());
      },
    );
  }
}
