import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final bool hideAppName;
  final double logoSize;
  final double appLabelSize;

  const Logo({Key? key, this.hideAppName: false, this.logoSize: 150, this.appLabelSize: 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(
            width: logoSize,
            height: logoSize,
            image: AssetImage('assets/images/te_amo_logo.png'),
          ),
          Text(
            "Te Amo",
            style: TextStyle(
              fontSize: appLabelSize,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
