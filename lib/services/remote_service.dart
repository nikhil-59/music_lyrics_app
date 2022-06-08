import 'package:music_lyrics_app/models/details.dart';
import 'package:music_lyrics_app/models/lyrics.dart';
import 'package:music_lyrics_app/models/tracks.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<TrackList>?> getTracks() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=5fe2f022917c7dcac11e206cb819bb71');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return tracksFromJson(json).message.body.trackList;
    }
  }

  Future<Lyrics?> getTrackLyrics(int trackID) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackID&apikey=5fe2f022917c7dcac11e206cb819bb71');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return trackLyricsFromJson(json).message.body.lyrics;
    }
  }

  Future<TrackDetails?> getTrackDetails(int trackID) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackID&apikey=5fe2f022917c7dcac11e206cb819bb71');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return trackDetailsFromJson(json);
    }
  }
}
