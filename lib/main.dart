import 'package:flutter/material.dart';
import 'package:te_amo/helpers/routes.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH_PAGE,
      onGenerateRoute: Routes.generateRoute,
    ),
  );
}