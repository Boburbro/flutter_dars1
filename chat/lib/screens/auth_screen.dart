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
  final _auth = FirebaseAuth.instance;

  bool isLoading = false;

  void _getUserDetails(Map<String, String> userData, bool isLogin) async {
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

        FirebaseFirestore.instance.collection("users").doc(user.user!.uid).set({
          "username": userData["username"]!.trim(),
          'email': email,
          "password": password,
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
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () =>
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
              child: const Text("Ok"),
            )
          ],
        ),
      );
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
