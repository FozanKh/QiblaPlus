import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qibla_plus/controller/location_controller.dart';
import 'package:qibla_plus/controller/logic_controller.dart';
import 'package:qibla_plus/model/constants.dart';
import 'package:qibla_plus/view/qibla_view.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with WidgetsBindingObserver {
  LogicController logic;
  AppLifecycleState appStatus;
  LocationController location;
  bool background = false;
  @override
  void initState() {
    super.initState();
    location = Provider.of<LocationController>(context, listen: false);
    logic = LogicController();
    WidgetsBinding.instance.addObserver(this);
    setUp();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        onPause();
        break;
      case AppLifecycleState.resumed:
        onResume();
        break;
      default:
    }
  }

  void onPause() {
    print('App is paused');
    location.timer.cancel();
    location.headingStream.cancel();
  }

  void onResume() {
    print('App is resumed');
    location.checkPermission();
    location.startListening();
  }

  setUp() async {
    await logic.setUpLang();
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.push(context, MaterialPageRoute(builder: (_) => QiblaView(logic: logic)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kGradientBackground,
      child: Center(
        child: Hero(
          tag: 'kabbah',
          child: Image.asset(
            'images/logo.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
