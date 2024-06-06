import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function pickImage;

  const UserImagePicker(this.pickImage, {super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImage;

  void _pickImage() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
      maxHeight: 150,
    );
    setState(() {
      pickedImage = File(image!.path);
    });

    widget.pickImage(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage: pickedImage == null ? null : FileImage(pickedImage!),
        ),
        const SizedBox(height: 10),
        TextButton(onPressed: _pickImage, child: const Text("Rasim tanlash"))
      ],
    );
  }
}
