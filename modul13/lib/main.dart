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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // double _cubeSize = 150;
  bool _isIncrease = true;

  late AnimationController _animationController;
  late Animation<Size> _cubeSizeAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _cubeSizeAnimation = Tween<Size>(
      begin: const Size(150, 150),
      end: const Size(300, 300),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    // _cubeSizeAnimation.addListener(() => setState(() {}));

    super.initState();
  }

  void _toggleSize() {
    setState(() {
      if (_isIncrease) {
        // _cubeSize = 300;
        _isIncrease = false;
        _animationController.forward();
      } else {
        // _cubeSize = 150;
        _isIncrease = true;
        _animationController.reverse();
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
          elevation: 0,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, widget) {
              return SizedBox(
                width: _cubeSizeAnimation.value.width,
                height: _cubeSizeAnimation.value.height,
                child: widget,
              );
            },
            child: const Center(
              child: Text("Salom Text!"),
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
