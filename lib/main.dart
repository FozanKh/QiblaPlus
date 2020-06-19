import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qibla_plus/controller/location_controller.dart';
import 'package:provider/provider.dart';
import 'view/loading_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));

    return ChangeNotifierProvider(
      create: (_) => LocationController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Tajawal'),
        home: LoadingView(),
      ),
    );
  }
}
