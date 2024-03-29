import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:te_amo/ui/login/log_in.dart';
import 'package:te_amo/ui/splash_page.dart';

class Routes {
  static const String SPLASH_PAGE = "/", LOG_IN = "/login";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_PAGE:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case LOG_IN:
        return MaterialPageRoute(builder: (_) => LogIn());
        // return PageRouteBuilder(
        //   maintainState: true,
        //   pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => LogIn(),
        // );
      default:
        return MaterialPageRoute(builder: (_) => PageNotFound());
    }
  }
}

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              borderRadius: BorderRadius.circular(10.0),
              elevation: 15.0,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.yellow,
                      size: 64,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      "Route not found!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  For different page route transition animations check out
//  https://medium.com/flutter-community/everything-you-need-to-know-about-flutter-page-route-transition-9ef5c1b32823
