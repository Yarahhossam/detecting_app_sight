import 'package:camera/camera.dart';
import 'package:detect_tflite/controller/scan_controller.dart';
import 'package:detect_tflite/controller/tts_controller.dart';
import 'package:detect_tflite/views/currency_detector_view.dart';
import 'package:detect_tflite/views/object_detector_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CameraView extends StatelessWidget {
  const CameraView({super.key, required this.lang});

  final String lang;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Object",
                ),
                Tab(
                  text: "Currency",
                ),
              ],
            ),
            title: Text('Detector App'),
          ),
          body: TabBarView(children: [
            ObjectDetector(lang: this.lang),
            CurrencyDetector(lang: this.lang),
          ]),
        ),
      ),
    );
  }
}
