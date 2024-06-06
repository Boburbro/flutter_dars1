import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat/helpers/custom_material_banner.dart';
import 'package:chat/widgets/pickers/user_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.getUserDetails, this.isLoading, {super.key});

  final Function getUserDetails;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool isLogin = true;

  final _userData = {
    "email": "",
    "username": "",
    "password": "",
  };

  File? userImage;

  void _pickImage(File image) {
    userImage = image;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      if (userImage == null && !isLogin) {
        Future.delayed(const Duration(seconds: 5)).then((_) {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        });
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showMaterialBanner(
            customMaterialBanner(
              title: "Nimadur bo'ldi",
              message: "Iltimos rasim kiriting!",
              contentType: ContentType.failure,
            ),
          );

        return;
      }
      _formKey.currentState!.save();
      widget.getUserDetails(_userData, isLogin, userImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isLogin) UserImagePicker(_pickImage),
                  TextFormField(
                    key: const ValueKey("email"),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email kiriting!';
                      } else if (!value.contains("@") || !value.contains(".")) {
                        return "To'g'ri email kiriting!";
                      } else if (value.length <= 5) {
                        return "Email manzili xato!";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      _userData['email'] = newValue!;
                    },
                  ),
                  const SizedBox(height: 10),
                  if (!isLogin)
                    TextFormField(
                      key: const ValueKey("username"),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username kiriting!';
                        } else if (value.length <= 5) {
                          return "Username kamida 6 ta bolishi kerak!";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (newValue) {
                        _userData['username'] = newValue!;
                      },
                    ),
                  const SizedBox(height: 10),
                  TextFormField(
                    key: const ValueKey("password"),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password kiriting!';
                      } else if (value.length <= 7) {
                        return "Password kamida 8 ta bolishi kerak!";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      _userData['password'] = newValue!;
                    },
                  ),
                  const SizedBox(height: 20),
                  if (widget.isLoading)
                    const CupertinoActivityIndicator(
                      color: CupertinoColors.activeBlue,
                    ),
                  if (!widget.isLoading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => setState(() {
                            isLogin = !isLogin;
                          }),
                          child: Text(isLogin ? "Ro'yxatdan o'tish" : "Kirish"),
                        ),
                        FilledButton(
                          onPressed: _submit,
                          child: Text(isLogin ? 'Kirish' : "Ro'yxatdan o'tish"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
