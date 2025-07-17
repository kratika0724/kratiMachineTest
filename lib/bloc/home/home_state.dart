import 'package:flutter/material.dart';

@immutable
abstract class HomeState {}

class HomeInitState extends HomeState {}

class LoadingState extends HomeState {}

class SuccessState extends HomeState {}

class ErrorState extends HomeState {}
