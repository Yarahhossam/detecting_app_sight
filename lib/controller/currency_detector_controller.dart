import 'package:camera/camera.dart';
import 'package:detect_tflite/controller/tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class CurrencyController extends GetxController {
  CurrencyController({required this.chosenLanguage});

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initCamera();
    initTFLite();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
    cameraController.stopImageStream();
    cameraController.dispose();
  }

  String chosenLanguage = "en-US";
  String chosenModel = "currency";

  late CameraController cameraController;
  late List<CameraDescription> cameras;

  final ttsController = TTSController();

  var isCameraInitialized = false;
  var cameraCount = 0;

  var x, y, w, h = 0.0;
  var label = "Default Label";

  initCamera() async {
    // this.ttsController.testTTS("Detecting", "en-US");
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();

      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.max,
      );

      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });

      isCameraInitialized = true;
      update();
    } else {
      print("Permission denied");
    }
  }

  initTFLite() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
      isAsset: true,
      numThreads: 2,
      useGpuDelegate: false,
    );

    print("init tflite");
  }

  objectDetector(CameraImage image) async {
    print("this.chosenLanguage: $chosenLanguage");
    var detector = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 2,
      rotation: 90,
      threshold: 0.1,
    );

    if (detector != null) {
      var ourDetectedObject = detector.first;
      print("Result is: $detector");
      if ((ourDetectedObject['confidence'] * 100) > 45) {
        label = ourDetectedObject['label'].toString();
        // h = ourDetectedObject['rect']['h'];
        // w = ourDetectedObject['rect']['w'];
        // x = ourDetectedObject['rect']['x'];
        // y = ourDetectedObject['rect']['y'];
      }
      print(ourDetectedObject);
      this
          .ttsController
          .testTTS(ourDetectedObject['label'].toString(), this.chosenLanguage);
      // await Tflite.close();
      update();
    }
  }
}