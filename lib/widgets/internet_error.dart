import 'package:flutter/material.dart';

class InternetError extends StatelessWidget {
  const InternetError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No internet connection',
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
