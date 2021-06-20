import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizeme/login_screen.dart';
import 'package:sizeme/main.dart';
import 'package:sizeme/result.dart';
class DrawerContent extends StatefulWidget {
  @override
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  final auth = FirebaseAuth.instance;
  Widget tiles(String name, IconData icon, Function function) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextButton.icon(onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => Result())), icon:  Icon(icon, color: Colors.grey[700]), label: Text(
              name,
              style: TextStyle(color: Colors.grey[700]),
            )), 
      ],
    );
  }

  // class _DrawerContentState extends State<DrawerContent> {
  // Widget tiles(String name, IconData icon, Function function) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       FlatButton.icon(
  //           onPressed: ()=>print('hello'),
  //           icon: Icon(icon, color: Colors.grey[700]),
  //           label: Text(
  //             name,
  //             style: TextStyle(color: Colors.grey[700]),
  //           )),
  //     ],
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        
        tiles('Home', Icons.home, () => 
         Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'sizer',)))),
        tiles(
            'Results',
            Icons.pages,
             () => Navigator.push(context,MaterialPageRoute(builder: (context) => Result()))),

        tiles(
            'LogOut',
            Icons.logout,
            () =>{
               auth.signOut(),
               Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),  
            })       
        
        ],
    );
  }
}
