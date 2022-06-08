part of 'connectivitybloc_bloc.dart';

@immutable
abstract class ConnectivityblocState {}

class ConnectivityblocInitial extends ConnectivityblocState {}

class ConnectivityblocSuccess extends ConnectivityblocState {}

class ConnectivityblocFailure extends ConnectivityblocState {}
