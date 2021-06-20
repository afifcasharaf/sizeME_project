import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizeme/camera_page_2.dart';
import 'package:sizeme/utils/camera.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String focalLength = "";
  CountDownController _controller = CountDownController();
  int _duration = 10;
  XFile? imageFile;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras![1], ResolutionPreset.max);
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Expanded(
              child: CameraPreview(
                controller!,
                child: ClipPath(
                  clipper: MyCustomClipper(context),
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 120.0,
                padding: EdgeInsets.all(20.0),
                color: Color.fromRGBO(00, 00, 00, 0.7),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          onTap: () {
                            print('hello');
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            child: Center(
                              child: CircularCountDownTimer(
                                duration: _duration,
                                initialDuration: 0,
                                controller: _controller,
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 2,
                                ringColor: Colors.grey[300]!,
                                ringGradient: null,
                                fillColor: Colors.grey[100]!,
                                fillGradient: null,
                                backgroundColor: Colors.black12,
                                backgroundGradient: null,
                                strokeWidth: 10.0,
                                strokeCap: StrokeCap.round,
                                textStyle: TextStyle(
                                    fontSize: 50.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textFormat: CountdownTextFormat.S,
                                isReverse: true,
                                isReverseAnimation: false,
                                isTimerTextShown: true,
                                autoStart: false,
                                onStart: () {
                                  print('Countdown Started');
                                },

                                onComplete: () {
                                  
                                    takePicture().then((XFile? file) {
                                      if (mounted) {
                                        setState(() {
                                          imageFile = file;
                                        });
                                        if (file != null){
                                           print('Picture saved to ${file.path}');
                                           uploadFile().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage2(imageUrl: imageUrl,))));
                                           
                                        }
                                         
                                      }
                                    });
                                  
                                  print('Countdown Ended');
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _controller.start(),
          backgroundColor: Colors.white,
          child: Text('Start',style: TextStyle(color:Colors.black87),),
        ),
      ),
    );
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      return null;
    }
  }

  Future uploadFile() async{
    if (imageFile==null) return;
    print('uploading');
    final fileName = basename(imageFile!.path);
    File file = File(imageFile!.path);
    final destination = 'files/$fileName';

    var snapshot = await FirebaseStorage.instance.ref().child(destination).putFile(file).whenComplete(() => print('hello'));
    print(snapshot);

    String downloadUrl = await snapshot.ref.getDownloadURL();
     print(downloadUrl);

    setState(() {
      imageUrl =  downloadUrl;
    });

    print('uploaded successfully');
    print(imageUrl);
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final BuildContext context;
  MyCustomClipper(this.context);

  @override
  Path getClip(Size size) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Path border = Path()..addRect(Rect.fromLTRB(0, 0, width / 20.5, height));
    border.addPath(border, Offset(width / 1.05, 0));

    Path leftLeg = Path()
      ..addRect(Rect.fromLTRB(width / 41, height / 3.5, width / 4.1, height));

    border.addPath(leftLeg, Offset(width / 42, 0));
    border.addPath(leftLeg, Offset(width - width / 3.43, 0));

    Path leftHand = Path()
      ..addRect(Rect.fromLTRB(width / 40, 0, width / 4.1, height / 4.5));

    border.addPath(leftHand, Offset(width / 7, 0));
    border.addPath(leftHand, Offset(width / 1.708, 0));

    Path centerCut = Path()
      ..addPolygon([
        Offset(width / 2 - width / 9, height / 2),
        Offset(width / 2 + width / 9, height / 2),
        Offset(width / 2, height / 2 - height / 2.5),
      ], true);

    border.addPath(centerCut, Offset(0, height / 2.3));
    return border;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
