import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_lyrics_app/bloc/connectivity/connectivitybloc_bloc.dart';
import 'package:music_lyrics_app/models/tracks.dart';
import 'package:music_lyrics_app/screens/track_details_lyrics.dart';
import 'package:music_lyrics_app/bloc/tracklist/tracklist_bloc.dart';
import 'package:music_lyrics_app/widgets/general_error.dart';
import 'package:music_lyrics_app/widgets/internet_error.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final trackListBloc = TracklistBloc();
  //final connectivityBloc = ConnectivityBloc();
  final ConnectivityblocBloc _connectivityblocBloc = ConnectivityblocBloc();
  @override
  void initState() {
    trackListBloc.eventSink.add(ViewAction.view);
    //connectivityBloc.eventSink.add(CheckNetwork.check);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Music Track List"),
        ),
        body: StreamBuilder<List<TrackList>>(
            stream: trackListBloc.listStream,
            builder: (context, snapshot) {
              return BlocConsumer<ConnectivityblocBloc, ConnectivityblocState>(
                listener: ((context, state) {
                  if (state is ConnectivityblocFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Internet Lost')));
                  }
                }),
                builder: (context, state) {
                  if (state is ConnectivityblocSuccess) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        itemCount: snapshot.data?.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              height: 100,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Icon(
                                      Icons.my_library_music,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![index].track.trackName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.deepOrangeAccent),
                                        ),
                                        Text(
                                          snapshot.data![index].track.albumName,
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        snapshot.data![index].track.artistName,
                                        style: TextStyle(
                                            color: Colors.grey.shade800,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TrackDetailsAndLyrics(
                                          trackID: snapshot
                                              .data![index].track.trackId,
                                        )),
                              );
                            },
                          );
                        }),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } else if (state is ConnectivityblocFailure) {
                    return InternetError();
                  } else {
                    return GeneralError();
                  }
                },
              );
            }));
  }
}
