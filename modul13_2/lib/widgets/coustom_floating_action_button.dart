import 'package:flutter/material.dart';

class CoustomFloatingActionButton extends StatelessWidget {
  const CoustomFloatingActionButton({
    required this.onPressed,
    required this.icon,
    super.key,
  });

  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: FloatingActionButton(
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
