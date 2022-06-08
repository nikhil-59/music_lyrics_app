import 'package:flutter/material.dart';

class GeneralError extends StatelessWidget {
  const GeneralError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Something went wrong',
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
