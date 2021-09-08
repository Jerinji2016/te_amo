import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:te_amo/helpers/animations.dart';
import 'package:te_amo/main.dart';
import 'package:te_amo/ui/login/user_details_view.dart';
import 'package:te_amo/widgets/country_code/country_adapter.dart';
import 'package:te_amo/widgets/logo.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  static const int RESET_DURATION = 120;
  ValueNotifier<int> _resentDuration = new ValueNotifier(RESET_DURATION);

  String get _resetTimeAsText {
    int hours = _resentDuration.value ~/ 60;
    int minutes = _resentDuration.value % 60;
    return "0$hours:${minutes < 10 ? "0$minutes" : minutes}";
  }

  bool canResend = false;

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
                  return Column(
                    children: [
                      PhoneVerificationView(_phoneCodeController),
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: ValueListenableBuilder(
                          builder: (BuildContext context, value, Widget? child) => Text(
                            "Resend verification code in $_resetTimeAsText",
                            style: TextStyle(color: Colors.white60),
                          ),
                          valueListenable: _resentDuration,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      if (canResend)
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _getVerificationCode,
                            splashColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "Resend",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
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
    setState(() {
      contentViewNo = view;
      _contentExitAnimationController.reset();
    });
    await _contentIntroAnimationController.forward(from: 0.0);
  }

  String? _verificationID;

  void _onNextTapped() async {
    switch (contentViewNo) {
      case _PHONE_NO_VIEW:
        if (_countryAdapter.country.code == "null") {
          _showErrorSnackBar("Invalid country code");
          return;
        }
        await _changeView(_VERIFICATION_CODE_VIEW);
        await _getVerificationCode();
        break;
      case _VERIFICATION_CODE_VIEW:
        if (_verificationID == null) {
          _showErrorSnackBar("Failed to verify, Please try again");
          _phoneCodeController.text = "";
          await _changeView(_PHONE_NO_VIEW);
          return;
        }
        String smsCode = _phoneCodeController.text.trim();
        PhoneAuthCredential credentials = PhoneAuthProvider.credential(verificationId: _verificationID!, smsCode: smsCode);
        _onVerificationCompleted(credentials);
        break;
      case _USER_DETAILS_VIEW:
        //  TODO: If new user add name and Dp
        //  else take user to chat page
        //  TODO: Add 2 step password lock
        break;
    }
  }

  Future<void> _getVerificationCode() async {
    String phoneNo = "${_countryAdapter.country.dialCode}${_phoneNoController.text.trim()}";

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
      timeout: Duration(seconds: RESET_DURATION),
    );
  }

  void _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print('LogInUtil._onVerificationCompleted: ${authCredential.smsCode}');
    UserCredential result = await _auth.signInWithCredential(authCredential);
    User? user = result.user;

    if (t != null) t?.cancel();

    if (user != null) {
      print("User verified");
      //  TODO: Take user to chat if user already exists
      await _changeView(_USER_DETAILS_VIEW);
    }
  }

  void _onVerificationFailed(FirebaseAuthException exception) {
    print('LogInUtil._onVerificationFailed: ${exception.message} =- ${exception.code}');

    String error;

    switch (exception.code) {
      case "invalid-phone-number":
        error = "Invalid phone number format";
        break;
      default:
        error = exception.message?.split(".").first ?? "Something went wrong";
    }

    _showErrorSnackBar(error);
  }

  void _onCodeSent(String verificationID, int? code) async {
    print('LogInUtil._onCodeSent: $verificationID - $int');
    _verificationID = verificationID;
    setState(() => canResend = false);
    _startResetCodeTimer();
  }

  void _codeAutoRetrievalTimeout(String data) {
    print('LogInUtil._codeAutoRetrievalTimeout: $data');
    setState(() => canResend = true);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: theme ? Colors.grey[300] : Colors.grey[900],
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: theme ? Colors.black : Colors.white),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: Text("OK", style: TextStyle(color: Colors.blue)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Timer? t;

  void _startResetCodeTimer() {
    _resentDuration.value = RESET_DURATION;

    if (t != null) t!.cancel();
    t = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resentDuration.value == 0) {
        timer.cancel();
        return;
      }
      _resentDuration.value--;
      print(_resentDuration.value);
    });
  }
}
