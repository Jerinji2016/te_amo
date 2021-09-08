import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:te_amo/helpers/routes.dart';

Color accentColor = Colors.blue[700]!;
Color errorColor = Colors.red[700]!;

bool theme = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH_PAGE,
      onGenerateRoute: Routes.generateRoute,
      themeMode: ThemeMode.dark,
      theme: ThemeData.light().copyWith(
        //  colors that needs to be replaced
        accentColor: accentColor,
        errorColor: errorColor,
      ),
      darkTheme: ThemeData.dark().copyWith(
        //  colors that needs to be replaced
        accentColor: accentColor,
        errorColor: errorColor,
        scaffoldBackgroundColor: Colors.black,
      ),
    ),
  );
}