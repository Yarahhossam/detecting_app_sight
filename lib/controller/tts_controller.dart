import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

FlutterTts flutterTts = FlutterTts();

class TTSController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  testTTS(String speakText, String lang) async {
    List<dynamic> languages = await flutterTts.getLanguages;

    print(languages);

    await flutterTts.setLanguage(lang);

    await flutterTts.setSpeechRate(0.3);

    await flutterTts.setVolume(1.0);

    // await flutterTts.setPitch(1.0);

    await flutterTts.speak(speakText);
    // await flutterTts.isLanguageAvailable("en-US");

    // // iOS, Android and Web only
    // //see the "Pausing on Android" section for more info
    // await flutterTts.pause();

    // // iOS, macOS, and Android only
    // // await flutterTts.synthesizeToFile("Hello World", Platform.isAndroid ? "tts.wav" : "tts.caf");
    // await flutterTts.synthesizeToFile("Hello World", "tts.wav");

    // await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});

    // // iOS only
    // await flutterTts.setSharedInstance(true);

    // // Android only
    // await flutterTts.setSilence(2);

    // await flutterTts.getEngines;

    // await flutterTts.getDefaultVoice;

    // await flutterTts.isLanguageInstalled("en-AU");

    // await flutterTts.areLanguagesInstalled(["en-AU", "en-US"]);

    // await flutterTts.setQueueMode(1);

    // await flutterTts.getMaxSpeechInputLength;
  }
}
