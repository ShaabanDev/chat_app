import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  final void Function(File image) getImageFn;
  ImagePick(this.getImageFn);
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File? pickedImage;
  void pickImage() async {
    ImagePicker gotImage = ImagePicker();
    final im = await gotImage.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (im == null) return;
    setState(() {
      pickedImage = File(im.path);
    });
    widget.getImageFn(pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
      ),
      TextButton.icon(
          onPressed: pickImage,
          icon: Icon(Icons.image),
          label: Text('Upload Image'))
    ]);
  }
}
