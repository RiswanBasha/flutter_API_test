import './post.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp1());

class MyApp1 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP_API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostsPage(),
    );
  }
}