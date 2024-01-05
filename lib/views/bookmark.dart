import 'package:flutter/material.dart';

class bookmark extends StatelessWidget {
  const bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Bookmark Page',
        style: TextStyle(fontSize: 50,
        color: Colors.black),
      ),
    );
  }
}
