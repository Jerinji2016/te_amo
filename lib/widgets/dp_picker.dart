import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class DpPicker {
  File? _imageFile;

  Future<File?> showPickerDialog(BuildContext context) async {
    await showDialog(
      builder: (context) => DpPickerDialog(
        onFilePicked: (file) => _imageFile = file,
      ),
      barrierDismissible: true,
      barrierColor: Colors.black26,
      context: context,
    );

    if (_imageFile != null) {
      print("Dp file obtained");
    }
    return _imageFile;
  }
}

class DpPickerDialog extends StatefulWidget {
  final Function(File file)? onFilePicked;

  const DpPickerDialog({Key? key, this.onFilePicked}) : super(key: key);

  @override
  _DpPickerDialogState createState() => _DpPickerDialogState();
}

class _DpPickerDialogState extends State<DpPickerDialog> {
  final double size = 300;
  File? _imageFile;
  bool isCropMode = false;

  String get _title => (_imageFile == null) ? "Pick an Image" : (isCropMode ? "Adjust image as required" : "Uploading...");

  @override
  void initState() {
    _pickImageFile().then((_) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
      child: AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                _title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              height: size,
              width: size,
              child: _imageFile != null
                  ? isCropMode
                      ? ClipOval(
                          child: Crop.file(
                            _imageFile!,
                            // key: _cropKey,
                            aspectRatio: 1.0 / 1.0,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey[800],
                          backgroundImage: FileImage(_imageFile!),
                        )
                  : GestureDetector(
                      onTap: _pickImageFile,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[800],
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).errorColor,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).accentColor,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
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

  Future<void> _pickImageFile() async {
    var img = await new ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (img != null)
        _imageFile = new File(img.path);
      else
        _imageFile = null;

      isCropMode = true;
    });
  }
}
