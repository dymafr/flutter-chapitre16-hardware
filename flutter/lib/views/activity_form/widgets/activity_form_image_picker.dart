import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_dyma_end/providers/city_provider.dart';
import 'package:provider/provider.dart';

class ActivityFormImagePicker extends StatefulWidget {
  final Function updateUrl;

  ActivityFormImagePicker({this.updateUrl});

  @override
  _ActivityFormImagePickerState createState() =>
      _ActivityFormImagePickerState();
}

class _ActivityFormImagePickerState extends State<ActivityFormImagePicker> {
  File _deviceImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      _deviceImage = await ImagePicker.pickImage(source: source);
      if (_deviceImage != null) {
        final url = await Provider.of<CityProvider>(context, listen: false)
            .uploadImage(_deviceImage);
        widget.updateUrl(url);
        setState(() {});
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.photo),
              label: Text('Galerie'),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
            FlatButton.icon(
              icon: Icon(Icons.photo_camera),
              label: Text('camera'),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          child: _deviceImage != null
              ? Image.file(
                  _deviceImage,
                  fit: BoxFit.cover,
                )
              : Text('Aucune image'),
        )
      ],
    );
  }
}
