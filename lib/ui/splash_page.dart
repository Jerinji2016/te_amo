import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:te_amo/widgets/logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    print("built splash page ${Theme.of(context).brightness}");

    return Scaffold(
      body: Center(
        child: Logo(),
      ),
    );
  }
}
