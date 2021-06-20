import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizeme/camera_page.dart';
import 'package:sizeme/camera_page_2.dart';
import 'package:sizeme/completed.dart';
import 'package:sizeme/login_screen.dart';
import 'package:sizeme/utils/camera.dart';
import 'package:sizeme/drawer.dart';

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SizeME',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
      ),
      drawer: Drawer(child:DrawerContent()),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset('images/sizeme.png')),

                  const SizedBox(height:50),

                  const Text('Place Your Body Within the Margin',style:TextStyle(fontSize: 20)),
                  const Text('to Get Sized',style:TextStyle(fontSize: 20)),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.70,
        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(20.0),
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black87,
          onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage())),
          elevation: 0,
          label: const Text(
            "Get Started",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  cameras = await availableCameras();
  runApp(const MyApp());
}