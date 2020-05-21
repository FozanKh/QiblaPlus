import 'package:flutter/material.dart';
import 'package:qibla_plus/controller/logic_controller.dart';
import 'package:qibla_plus/model/constants.dart';
import 'package:qibla_plus/view/qibla_view.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    setUp();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('LifeCycleState = $state');
  }

  setUp() async {
    var logic = LogicController();
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
