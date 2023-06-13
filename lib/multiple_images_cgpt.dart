import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class ImageCaptureScreen extends StatefulWidget {
  @override
  _ImageCaptureScreenState createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  List<File> capturedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Capture'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: capturedImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Boxingimage( image: capturedImages[index]);
              },
            ),
          ),
          ElevatedButton(
            child: Text('Capture Image'),
            onPressed: _captureImage,
          ),
        ],
      ),
    );
  }

  void _captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        capturedImages.add(File(pickedFile.path));
      });
    }
  }

  Widget Boxingimage({
    required File image,
  }){
    return Container(
      width: MediaQuery.of(context).size.width/4,
      height: MediaQuery.of(context).size.height/4,
      child: Center(
          child: Image.file(image)
      ),
    );
  }
}

