import 'package:flutter/material.dart';
import 'package:qibla_plus/controller/location_controller.dart';
import 'package:qibla_plus/view/qibla_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => LocationController(),
        child: MaterialApp(
          home: QiblaView(),
        ),
      );
}
