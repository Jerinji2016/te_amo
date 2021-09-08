import 'package:flutter/material.dart';
import 'package:te_amo/helpers/pref_manager.dart';
import 'package:te_amo/helpers/routes.dart';
import 'package:te_amo/widgets/logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    await PrefManager.initialize();
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, Routes.LOG_IN);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Hero(
            tag: "splash-logo",
            child: Logo(logoSize: 150),
          ),
        ),
      );
}
