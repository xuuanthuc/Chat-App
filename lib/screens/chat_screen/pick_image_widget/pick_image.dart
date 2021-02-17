import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  PickImage(this.imagePcikFn);
  final void Function(File pickImage) imagePcikFn;
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File _pickImage;

  void _imagePicker() async {
    final _pickImageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      _pickImage = _pickImageFile;
    });
    widget.imagePcikFn(_pickImage);
  }

  void _imageChosen() async {
    final _chosenImageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickImage = _chosenImageFile;
    });
    widget.imagePcikFn(_pickImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          child: CircleAvatar(
            backgroundColor: Colors.pinkAccent,
            radius: 50,
            backgroundImage: _pickImage == null ? null : FileImage(_pickImage),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton.icon(
                onPressed: _imagePicker,
                icon: Icon(
                  Icons.camera_enhance,
                  color: Colors.pinkAccent,
                ),
                label: Text(
                  'Take Image',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
              FlatButton.icon(
                onPressed: _imageChosen,
                icon: Icon(
                  Icons.image,
                  color: Colors.pinkAccent,
                ),
                label: Text(
                  'Choose Image',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
