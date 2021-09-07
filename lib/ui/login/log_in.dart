import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:te_amo/helpers/animations.dart';
import 'package:te_amo/widgets/logo.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;

  TextEditingController _phoneNoController = new TextEditingController();

  int contentViewNo = 0;

  @override
  void initState() {
    super.initState();

    _logoAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
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
    return Scaffold(
      body: AnimatedBuilder(
        animation: _logoAnimationController,
        builder: (_, __) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Hero(
                  tag: "splash-logo",
                  child: Logo(logoSize: 100, appLabelSize: 24, key: UniqueKey(),),
                ),
              ),
            ),
            Expanded(
              flex: 2,
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
                  child: GetPhoneNumberView(_phoneNoController),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.translate(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onNextTapped() {
    switch (contentViewNo) {
      case 0:
        //  Generate otp for phone no verification
        break;
      case 1:
        //  Check verification code from otp
        break;
      case 2:
        //  If new user add name and Dp
        //  else take user to chat page
        //  TODO: Add 2 step password lock
        break;
    }
  }
}

class GetPhoneNumberView extends StatelessWidget {
  final TextEditingController _phoneNoController;

  const GetPhoneNumberView(this._phoneNoController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.5,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 5.0),
            child: Text(
              "Your Phone",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  "+91(IN)",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                Expanded(
                  child: TextField(
                    controller: _phoneNoController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Enter Phone Number",
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.green[700]!,
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Colors.blue[500]!,
                          width: 2,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    onChanged: (text) {
                      if (text.length == 10) FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
