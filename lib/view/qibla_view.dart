import 'package:flutter/material.dart';

class QiblaView extends StatefulWidget {
  @override
  _QiblaViewState createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff4b7aa1), Color(0xff263a4c)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
