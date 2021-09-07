import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool hideAppName;

  const Logo({Key? key, this.hideAppName: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          width: 150,
          height: 150,
          image: AssetImage('assets/images/te_amo_logo.png'),
        ),
        Text(
          "Te Amo",
          style: TextStyle(
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
