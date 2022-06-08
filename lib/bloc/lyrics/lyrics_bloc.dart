import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:music_lyrics_app/models/lyrics.dart';
import 'package:music_lyrics_app/services/remote_service.dart';

class TrackLyricsBloc {
  final _stateStreamController = StreamController<Lyrics>();
  StreamSink<Lyrics> get _lyricsSink => _stateStreamController.sink;
  Stream<Lyrics> get lyricsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<int>();
  StreamSink<int> get eventSink => _eventStreamController.sink;
  Stream<int> get _eventStream => _eventStreamController.stream;

  TrackLyricsBloc() {
    _eventStream.listen(
      (event) async {
        try {
          var lyrics = await RemoteService().getTrackLyrics(event);
          _lyricsSink.add(lyrics!);
        } on Exception catch (e) {
          _lyricsSink.addError("Something went wrong");
        }
      },
    );
  }
}
