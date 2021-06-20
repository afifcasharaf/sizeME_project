import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizeme/completed.dart';
import 'package:sizeme/utils/camera.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class CameraPage2 extends StatefulWidget {
  String imageUrl;
  CameraPage2({
    required this.imageUrl,
  });
  
  @override
  _CameraPage2State createState() => _CameraPage2State();
}

class _CameraPage2State extends State<CameraPage2> {
  String focalLength = "";
  CountDownController _controller = CountDownController();
  int _duration = 10;
  XFile? imageFile;
  late String imageUrl2;

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
                                        if (file != null && mounted){
                                          print('Picture saved to ${file.path}');

                                          uploadFile().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => Done())));
                                        }
                                          
                                      }
                                      Navigator.pop(context);
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

            Align(
              child:Container(
                child:Opacity(opacity:0.5,child:Image.asset('images/side.png',scale: 0.7,))
              ),
            )

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

    final fileName = basename(imageFile!.path);
    File file = File(imageFile!.path);
    final destination = 'files2/$fileName';

    var snapshot = await FirebaseStorage.instance.ref().child(destination).putFile(file).whenComplete(() => print('hello'));

    var downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      imageUrl2 = downloadUrl;
    });

    print(widget.imageUrl);
    print(imageUrl2);

    print('uploaded successfully');
  }
}

