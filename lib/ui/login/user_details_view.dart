import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:te_amo/widgets/dp_picker.dart';

class UserDetailsView extends StatefulWidget {
  final TextEditingController _usernameController;

  UserDetailsView(this._usernameController, {Key? key}) : super(key: key);

  @override
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  File? _userImage;
  final GlobalKey _cropKey = GlobalKey();
  bool _cropFlag = false;

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
                  width: 2,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Your Name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            //  TDOO: Get image
            onTap: _getImage,
            child: Container(
              decoration: BoxDecoration(color: Colors.blueGrey, shape: BoxShape.circle),
              width: 80,
              height: 80,
              child: ClipOval(
                child: _userImage == null
                    ? Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 20,
                      )
                    : _cropFlag
                        ? Crop.file(
                            _userImage!,
                            key: _cropKey,
                            aspectRatio: 1.0 / 1.0,
                          )
                        : Image.file(_userImage!),
              ),
            ),
          ),
          // SizedBox(height: 10),
          Expanded(
            child: Container(
              child: TextField(
                controller: widget._usernameController,
                cursorRadius: Radius.circular(10),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Full Name",
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
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getImage() async {
    DpPicker dpPicker = new DpPicker();
    File? image = await dpPicker.showPickerDialog(context);
  }
}
