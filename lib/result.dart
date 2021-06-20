import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black87,
        title:Text('Your Measurments'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(children: [
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: const Text('Neck: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
              ListTile(
                leading: const Text('Shoulders: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
              ListTile(
                leading: const Text('Chest: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
              ListTile(
                leading: const Text('Arms: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
              ListTile(
                leading: const Text('Belly: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
              ListTile(
                leading: const Text('Waist: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
              ListTile(
                leading: const Text('Thighs: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
              ListTile(
                leading: const Text('Legs: ',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                title: const Text('12.5'+' inch',style: TextStyle(fontSize:20),), 
              ),
              Divider(),
            ],
          )
        ],),
      ),
      
    );
  }
}