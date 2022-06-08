import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'connectivitybloc_event.dart';
part 'connectivitybloc_state.dart';

class ConnectivityblocBloc
    extends Bloc<ConnectivityblocEvent, ConnectivityblocState> {
  StreamSubscription? subscription;
  ConnectivityblocBloc() : super(ConnectivityblocInitial()) {
    on<OnConnectedEvent>((event, emit) => emit(ConnectivityblocSuccess()));
    on<OnNotConnectedEvent>((event, emit) => emit(ConnectivityblocFailure()));
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(OnConnectedEvent());
      } else {
        add(OnNotConnectedEvent());
      }
    });
  }
  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
