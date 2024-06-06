import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat/helpers/custom_material_banner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
  }

  final _auth = FirebaseAuth.instance;

  bool isLoading = false;

  void _getUserDetails(
      Map<String, String> userData, bool isLogin, File? userImage) async {
    setState(() {
      isLoading = true;
    });
    UserCredential user;
    final email = userData['email']!.trim();
    final password = userData['password']!.trim();

    try {
      if (isLogin) {
        user = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        user = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final imagePath = FirebaseStorage.instance
            .ref()
            .child('images')
            .child('${user.user!.uid}.jpg');

        await imagePath.putFile(userImage!);

        final url = await imagePath.getDownloadURL();

        FirebaseFirestore.instance.collection("users").doc(user.user!.uid).set({
          "username": userData["username"]!.trim(),
          'email': email,
          "password": password,
          "image": url,
        });
      }
      setState(() {
        isLoading = false;
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      var message = "Kechirasiz malumotlarda xatolik.\nQayta urining!";
      if (e.message != null) {
        message = e.message!;
      }

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..hideCurrentMaterialBanner()
        ..showMaterialBanner(
          customMaterialBanner(
            title: "Nimadur bo'ldi",
            message: message,
            contentType: ContentType.failure,
          ),
        );

      Future.delayed(const Duration(seconds: 3)).then((_) {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_getUserDetails, isLoading),
    );
  }
}
