
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:te_amo/helpers/animations.dart';
import 'package:te_amo/ui/login/user_details_view.dart';
import 'package:te_amo/widgets/country_code/country_adapter.dart';
import 'package:te_amo/widgets/logo.dart';

import 'log_in_util.dart';
import 'phone_number_view.dart';
import 'phone_verification_view.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _contentExitAnimationController;
  late AnimationController _contentIntroAnimationController;

  TextEditingController _phoneNoController = new TextEditingController();
  TextEditingController _phoneCodeController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();

  static const int _PHONE_NO_VIEW = 0, _VERIFICATION_CODE_VIEW = 1, _USER_DETAILS_VIEW = 2;

  int contentViewNo = _PHONE_NO_VIEW;
  final LogInUtil logInUtil = LogInUtil();

  late CountryAdapter _countryAdapter;

  @override
  void initState() {
    super.initState();

    _countryAdapter = CountryAdapter(context);

    _logoAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _contentIntroAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _contentIntroAnimationController.animateTo(1.0, duration: Duration(seconds: 0));

    _contentExitAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _logoAnimationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();

    _phoneNoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _logoAnimationController,
      builder: (_, __) => Scaffold(
        floatingActionButton: Transform.translate(
          offset: Offset(
            0,
            tweenValue(
              20,
              0,
              _logoAnimationController,
              curve: Interval(
                0.6,
                1.0,
                curve: Curves.ease,
              ),
            ).value,
          ),
          child: Opacity(
            opacity: tweenValue(
              0.0,
              1.0,
              _logoAnimationController,
              curve: Interval(
                0.6,
                1,
                curve: Curves.ease,
              ),
            ).value,
            child: Material(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(50.0),
              child: InkWell(
                onTap: _onNextTapped,
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(
                    Icons.arrow_forward_outlined,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: "splash-logo",
                  child: Logo(
                    logoSize: 100,
                    appLabelSize: 24,
                    key: UniqueKey(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Transform.translate(
                offset: Offset(
                    0,
                    tweenValue(
                      30,
                      0,
                      _logoAnimationController,
                      curve: Interval(0.4, 0.8, curve: Curves.ease),
                    ).value),
                child: Opacity(
                  opacity: tweenValue(
                    0,
                    1,
                    _logoAnimationController,
                    curve: Interval(0.4, 0.8, curve: Curves.ease),
                  ).value,
                  child: _contentView(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contentView() => AnimatedBuilder(
        animation: _contentIntroAnimationController,
        builder: (context, child) => Opacity(
          opacity: tweenValue(0, 1, _contentIntroAnimationController, curve: Curves.fastLinearToSlowEaseIn).value,
          child: Transform.translate(
            offset: Offset(tweenValue(50, 0, _contentIntroAnimationController, curve: Curves.fastLinearToSlowEaseIn).value, 0),
            child: child!,
          ),
        ),
        child: AnimatedBuilder(
          animation: _contentExitAnimationController,
          builder: (context, child) => Opacity(
            opacity: tweenValue(1, 0, _contentExitAnimationController, curve: Curves.fastLinearToSlowEaseIn).value,
            child: Transform.translate(
              offset: Offset(0, tweenValue(0, 30, _contentExitAnimationController, curve: Curves.fastLinearToSlowEaseIn).value),
              child: Transform.scale(
                scale: tweenValue(1, 0, _contentExitAnimationController, curve: Curves.fastLinearToSlowEaseIn).value,
                child: child!,
              ),
            ),
          ),
          child: Builder(
            builder: (_) {
              switch (contentViewNo) {
                case 1:
                  return PhoneVerificationView(_phoneCodeController);
                case 2:
                  return UserDetailsView(_usernameController);
                default:
                  return PhoneNumberView(_phoneNoController, _countryAdapter);
              }
            },
          ),
        ),
      );

  Future<void> _changeView(int view) async {
    await _contentExitAnimationController.forward(from: 0.0);
    setState((){
      contentViewNo = view;
      _contentExitAnimationController.reset();
    });
    await _contentIntroAnimationController.forward(from: 0.0);
  }

  void _onNextTapped() async {
    switch (contentViewNo) {
      case _PHONE_NO_VIEW:
        await _changeView(_VERIFICATION_CODE_VIEW);
        break;
      case _VERIFICATION_CODE_VIEW:
        await _changeView(_USER_DETAILS_VIEW);
        //  Check verification code from otp
        break;
      case _USER_DETAILS_VIEW:
        //  If new user add name and Dp
        //  else take user to chat page
        //  TODO: Add 2 step password lock
        break;
    }
  }
}
