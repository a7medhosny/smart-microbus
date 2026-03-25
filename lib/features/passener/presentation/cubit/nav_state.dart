part of 'nav_cubit.dart';

abstract class NavState {}

class NavInitial extends NavState {}

class NavInitialized extends NavState {}

class NavChanged extends NavState {}