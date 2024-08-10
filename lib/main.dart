import 'package:flutter/material.dart';
import 'package:roulette_task/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isSubscribed = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(
        isSubscribed: isSubscribed,
        onSubscribe: () {
          setState(() {
            isSubscribed = !isSubscribed;
          });
        },
      ),
    );
  }
}
