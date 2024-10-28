import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('search screen',style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
