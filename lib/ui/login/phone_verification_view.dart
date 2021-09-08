import 'package:flutter/material.dart';

class PhoneVerificationView extends StatelessWidget {
  final TextEditingController _phoneCodeController;

  const PhoneVerificationView(this._phoneCodeController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Verification Code",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            child: TextField(
              showCursor: true,
              controller: _phoneCodeController,
              onChanged: (text) {
                if (text.length == 6) FocusScope.of(context).requestFocus(FocusNode());
              },
              cursorRadius: Radius.circular(10),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: "Enter the Code",
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red[500]!, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue[500]!, width: 2),
                ),
                hintStyle: TextStyle(color: Colors.blueGrey),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
