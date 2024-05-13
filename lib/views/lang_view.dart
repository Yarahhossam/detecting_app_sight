import 'package:detect_tflite/controller/tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:detect_tflite/views/camera_view.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LangView extends StatelessWidget {
  // const LangView({super.key});

  final ttsController = TTSController();

  // CustomButton({Key key, this.buttonType}) : super(key: key);
  LangView() {
    ttsController.testTTS("Choose Language: Arabic, or English.", "en-US");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choose a language'),
        ),
        body: GetBuilder<TTSController>(
            init: TTSController(),
            builder: (controller) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.testTTS("Hello", "en-US");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraView(
                                lang: "ar",
                              )),
                        );
                      },
                      child: Text('Arabic'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CameraView(
                                lang: "en-US",
                              )),
                        );
                      },
                      child: Text('English'),
                    ),
                  ],
                ),
              );
            }));
  }
}