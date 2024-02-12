import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp/Screens/CameraView.dart';
import 'package:whatsapp/Screens/VideoView.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCamera = true;
  double transform = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController?.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                    width: double.infinity,
                    child: CameraPreview(_cameraController!));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? _cameraController?.setFlashMode(FlashMode.torch)
                              : _cameraController?.setFlashMode(FlashMode.off);
                        },
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController?.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          final video =
                              await _cameraController?.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) =>
                                    VideoView(path: video!.path),
                              ));
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 80,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            isCamera = !isCamera;
                            transform = transform + pi;
                          });
                          int cameraPos = isCamera ? 0 : 1;

                          _cameraController = CameraController(
                              cameras![cameraPos], ResolutionPreset.high);
                          cameraValue = _cameraController?.initialize();
                        },
                        icon: Transform.rotate(
                          angle: transform,
                          child: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Hold for video, tab for photo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    final path =
        ((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    final picture = await _cameraController?.takePicture();

    print(picture?.path);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => CameraViewPage(path: picture!.path),
        ));
  }
}
