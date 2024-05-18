import 'package:flutter/material.dart';
import 'package:modul13_1/second_page.dart';

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
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
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
  double _cubeSize = 150;
  // double _fontSize = 0;
  bool _isIncrease = true;
  Color _color = Colors.red;

  // late Animation<double> _opacity;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // _opacity = Tween<double>(
    //   begin: 0.0,
    //   end: 1.0,
    // ).animate(
    //   CurvedAnimation(
    //     parent: _animationController,
    //     curve: Curves.easeIn,
    //   ),
    // );

    super.initState();
  }

  // ignore: unused_element
  void _toggleSize() {
    setState(() {
      if (_isIncrease) {
        _cubeSize = 300;
        _isIncrease = false;
        _color = Colors.blue;
        // _fontSize = 30;
        _animationController.forward();
      } else {
        _cubeSize = 150;
        _isIncrease = true;
        _color = Colors.red;
        // _fontSize = 0;
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
          elevation: 10,
          child: AnimatedContainer(
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300),
            width: _cubeSize,
            height: _cubeSize,
            color: _color,
            child: Center(
              child: Hero(
                tag:
                    "https://images.unsplash.com/photo-1715966966827-25a227141ee9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                child: FadeInImage(
                  fit: BoxFit.cover,
                  width: _cubeSize,
                  height: _cubeSize,
                  placeholder: const AssetImage("assets/car.jpg"),
                  image: const NetworkImage(
                      "https://images.unsplash.com/photo-1715966966827-25a227141ee9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),

                  // AnimatedDefaultTextStyle(
                  //   style: TextStyle(
                  //     fontSize: _fontSize,
                  //     color: Colors.white,
                  //   ),
                  //   duration: const Duration(milliseconds: 300),
                  //   child: const Text(
                  //     "Salom text",
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const SecondPage(),
          ),
        ), // _toggleSize,
        tooltip: 'Increment',
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
