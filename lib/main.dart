import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_lyrics_app/bloc/connectivity/connectivitybloc_bloc.dart';
import 'package:music_lyrics_app/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityblocBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Lyricism',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage(),
      ),
    );
  }
}
