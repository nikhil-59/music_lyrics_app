import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_lyrics_app/bloc/connectivity/connectivitybloc_bloc.dart';
import 'package:music_lyrics_app/models/details.dart';
import 'package:music_lyrics_app/models/lyrics.dart';
import 'package:music_lyrics_app/bloc/lyrics/lyrics_bloc.dart';
import 'package:music_lyrics_app/bloc/details/track_details_bloc.dart';
import 'package:music_lyrics_app/widgets/general_error.dart';
import 'package:music_lyrics_app/widgets/internet_error.dart';

class TrackDetailsAndLyrics extends StatefulWidget {
  TrackDetailsAndLyrics({Key? key, required this.trackID}) : super(key: key);
  int trackID;
  @override
  State<TrackDetailsAndLyrics> createState() =>
      _TrackDetailsAndLyricsState(trackID);
}

class _TrackDetailsAndLyricsState extends State<TrackDetailsAndLyrics> {
  _TrackDetailsAndLyricsState(this.trackID);
  int trackID;
  final trackDetailsBloc = TrackDetailsBloc();
  final trackLyricsBloc = TrackLyricsBloc();
  @override
  void initState() {
    trackDetailsBloc.eventSink.add(trackID);
    trackLyricsBloc.eventSink.add(trackID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle contentStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
    );
    TextStyle headingStyle = const TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange);
    var box = const SizedBox(
      height: 15,
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Track Details',
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<TrackDetails>(
            stream: trackDetailsBloc.detailsStream,
            builder: (context, detailSnapshot) {
              return StreamBuilder<Lyrics>(
                  stream: trackLyricsBloc.lyricsStream,
                  builder: (context, lyricSnapshot) {
                    return BlocBuilder<ConnectivityblocBloc,
                        ConnectivityblocState>(
                      builder: (context, state) {
                        if (state is ConnectivityblocSuccess) {
                          if (detailSnapshot.hasData) {
                            return SingleChildScrollView(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: headingStyle,
                                  ),
                                  Text(
                                    detailSnapshot.data?.message.body.track
                                        .trackName as String,
                                    style: contentStyle,
                                  ),
                                  box,
                                  Text(
                                    'Artist',
                                    style: headingStyle,
                                  ),
                                  Text(
                                    detailSnapshot.data?.message.body.track
                                        .artistName as String,
                                    style: contentStyle,
                                  ),
                                  box,
                                  Text(
                                    'Album Name',
                                    style: headingStyle,
                                  ),
                                  Text(
                                    detailSnapshot.data?.message.body.track
                                        .albumName as String,
                                    style: contentStyle,
                                  ),
                                  box,
                                  Text(
                                    'Rating',
                                    style: headingStyle,
                                  ),
                                  Text(
                                    detailSnapshot
                                        .data?.message.body.track.trackRating
                                        .toString() as String,
                                    style: contentStyle,
                                  ),
                                  box,
                                  Text(
                                    'Lyrics',
                                    style: headingStyle,
                                  ),
                                  if (lyricSnapshot.hasData) ...{
                                    Text(
                                      lyricSnapshot.data?.lyricsBody as String,
                                      style: contentStyle,
                                    )
                                  } else ...{
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  }
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        } else if (state is ConnectivityblocFailure) {
                          return const InternetError();
                        } else {
                          return const GeneralError();
                        }
                      },
                    );
                  });
            }));
  }
}
