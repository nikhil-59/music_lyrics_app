part of 'connectivitybloc_bloc.dart';

@immutable
abstract class ConnectivityblocEvent {}

class OnConnectedEvent extends ConnectivityblocEvent {}

class OnNotConnectedEvent extends ConnectivityblocEvent {}
