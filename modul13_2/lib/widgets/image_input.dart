import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys_path;

class ImageInput extends StatefulWidget {
  final Function takeImage;
  const ImageInput({
    required this.takeImage,
    super.key,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  void _takePicture(ImageSource _imageSource) async {
    final imagePicker = ImagePicker();

    final photo = await imagePicker.pickImage(
      source: _imageSource,
      maxWidth: 600,
    );
    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });
      final pathProvider = await sys_path.getApplicationDocumentsDirectory();
      final firstName = path.basename(photo.path);
      _imageFile!.copy("${pathProvider.path}/$firstName");

      widget.takeImage(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text("Rasmi yo'q"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () => _takePicture(ImageSource.camera),
              icon: const Icon(Icons.camera_alt_rounded),
              label: const Text(
                "Kamera",
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () => _takePicture(ImageSource.gallery),
              icon: const Icon(Icons.image_rounded),
              label: const Text(
                "Gallery",
                style: TextStyle(
                  color: Colors.indigo,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
