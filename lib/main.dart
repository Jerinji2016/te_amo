import 'package:flutter/material.dart';
import 'package:te_amo/helpers/routes.dart';

Color accentColor = Colors.blue[700]!;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH_PAGE,
      onGenerateRoute: Routes.generateRoute,
      themeMode: ThemeMode.dark,
      theme: ThemeData.light().copyWith(
        //  colors that needs to be replaced
        accentColor: accentColor,
      ),
      darkTheme: ThemeData.dark().copyWith(
        //  colors that needs to be replaced
        accentColor: accentColor,
        scaffoldBackgroundColor: Colors.black,
      ),
    ),
  );
}