import 'package:flutter/material.dart';
import 'package:qibla_plus/view/qibla_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(fontFamily: 'SF-Pro'),
        home: QiblaView(),
      );
}
