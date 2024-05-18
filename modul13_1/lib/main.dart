import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _cubeSize = 150;
  bool _isIncrease = true;
  Color _color = Colors.deepPurple;

  void _toggleSize() {
    setState(() {
      if (_isIncrease) {
        _cubeSize = 300;
        _isIncrease = false;
        _color = Colors.red;
      } else {
        _cubeSize = 150;
        _isIncrease = true;
        _color = Colors.deepPurple;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          child: AnimatedContainer(
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
            width: _cubeSize,
            height: _cubeSize,
            color: _color,
            child: const Center(
              child: Text("Salom text"),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSize,
        tooltip: 'Increment',
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
