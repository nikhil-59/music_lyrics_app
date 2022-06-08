import 'dart:async';

import 'package:music_lyrics_app/models/tracks.dart';
import 'package:music_lyrics_app/services/remote_service.dart';

enum ViewAction { view }

class TracklistBloc {
  final _stateStreamController = StreamController<List<TrackList>>();
  StreamSink<List<TrackList>> get _listSink => _stateStreamController.sink;
  Stream<List<TrackList>> get listStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<ViewAction>();
  StreamSink<ViewAction> get eventSink => _eventStreamController.sink;
  Stream<ViewAction> get _eventStream => _eventStreamController.stream;

  TracklistBloc() {
    _eventStream.listen((event) async {
      if (event == ViewAction.view) {
        try {
          var list = await RemoteService().getTracks();
          _listSink.add(list!);
        } on Exception catch (e) {
          _listSink.addError("Something went wrong");
        }
      }
    });
  }
}
