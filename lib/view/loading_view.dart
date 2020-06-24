import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qibla_plus/controller/location_controller.dart';
import 'package:qibla_plus/controller/logic_controller.dart';
import 'package:qibla_plus/view/qibla_view.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with WidgetsBindingObserver {
  LogicController logic;
  AppLifecycleState appStatus;
  bool background = false;
  TimeOfDay time;
  @override
  void initState() {
    super.initState();
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
    time = TimeOfDay.now();
    Provider.of<LocationController>(context, listen: false).stopListening();
  }

  void onResume() async {
    await Provider.of<LocationController>(context, listen: false).checkStatus();
    Provider.of<LocationController>(context, listen: false).startListening();
  }

  setUp() async {
    await logic.setUpLang();
    Provider.of<LocationController>(context, listen: false).setUpQibla();
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 700),
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
        pageBuilder: (_, __, ___) => QiblaView(logic: logic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Hero(
        tag: 'logo',
        child: Image.asset(
          'assets/images/logo.png',
          height: MediaQuery.of(context).size.width / 3,
          width: MediaQuery.of(context).size.width / 3,
        ),
      ),
    );
  }
}
