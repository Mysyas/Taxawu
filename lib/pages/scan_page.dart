import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanPhotoPage extends StatefulWidget {
  @override
  State<ScanPhotoPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPhotoPage> {
  File? image;
  final picker = ImagePicker();

  Future<void> takePhoto() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> pickFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photographie Flutter"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null) Image.file(image!, height: 250),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: takePhoto,
            icon: Icon(Icons.camera_alt),
            label: Text("Prendre une photo"),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: pickFromGallery,
            icon: Icon(Icons.photo),
            label: Text("Galerie"),
          ),
        ],
      ),
    );
  }
}
