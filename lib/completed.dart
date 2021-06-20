import 'package:flutter/material.dart';
import 'package:sizeme/main.dart';

class Done extends StatefulWidget {
  @override
  _DoneState createState() => _DoneState();
}

class _DoneState extends State<Done> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) =>Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    const MyHomePage(title: 'SizeME',)), (Route<dynamic> route) => false),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.task_alt),
          const Text('You Have Been Measured Successfully :)',style: TextStyle(color: Colors.black87,fontSize: 15, ),)
        ],
      )
    );
  }
}