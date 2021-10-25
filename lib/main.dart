import 'package:audio_services/audio-services.dart';
import 'package:audio_services/recorder-screen.dart';
import 'package:audio_services/test-audio-service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
            // TestAudioService(),
            SimpleRecorder());
  }
}
