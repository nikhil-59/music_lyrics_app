import 'dart:async';
import 'package:music_lyrics_app/models/details.dart';
import 'package:http/http.dart' as http;
import 'package:music_lyrics_app/services/remote_service.dart';

class TrackDetailsBloc {
  final _stateStreamController = StreamController<TrackDetails>();
  StreamSink<TrackDetails> get _detailsSink => _stateStreamController.sink;
  Stream<TrackDetails> get detailsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<int>();
  StreamSink<int> get eventSink => _eventStreamController.sink;
  Stream<int> get _eventStream => _eventStreamController.stream;

  TrackDetailsBloc() {
    _eventStream.listen(
      (event) async {
        try {
          var details = await RemoteService().getTrackDetails(event);
          _detailsSink.add(details!);
        } on Exception catch (e) {
          _detailsSink.addError("Something went wrong");
        }
      },
    );
  }
}
