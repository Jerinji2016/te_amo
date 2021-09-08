import 'package:flutter/material.dart';
import 'package:te_amo/widgets/country_code/country.dart';
import 'package:te_amo/widgets/country_code/country_adapter.dart';

class PhoneNumberView extends StatefulWidget {
  final TextEditingController _phoneNoController;
  final CountryAdapter _countryAdapter;

  late final TextEditingController _countryCodeController;

  PhoneNumberView(this._phoneNoController, this._countryAdapter, {Key? key}) : super(key: key) {
    _countryCodeController = TextEditingController(text: _countryAdapter.country.dialCode);
  }

  @override
  _PhoneNumberViewState createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "${widget._countryAdapter.country.code} - ${widget._countryAdapter.country.name}",
              style: TextStyle(color: Colors.blueGrey, fontSize: 16),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 50.0,
                  child: TextField(
                    style: TextStyle(color: Colors.blueGrey),
                    onChanged: (code) => setState(
                      () => widget._countryAdapter.country = widget._countryAdapter.values.firstWhere(
                        (element) => element.dialCode == code.trim(),
                        orElse: () => Country.none(code),
                      ),
                    ),
                    controller: widget._countryCodeController,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widget._phoneNoController,
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
