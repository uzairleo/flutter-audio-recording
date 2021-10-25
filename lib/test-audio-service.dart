import 'dart:async';
import 'dart:io';
import 'package:audio_services/audio-services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

///
typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class TestAudioService extends StatefulWidget {
  @override
  _TestAudioServiceState createState() => _TestAudioServiceState();
}

class _TestAudioServiceState extends State<TestAudioService> {
  AudioServices? audioService;
  @override
  void initState() {
    audioService = AudioServices();
    super.initState();
  }

  @override
  void dispose() {
    audioService!.dispose();
    super.dispose();
  }

// ----------------------------- UI --------------------------------------------

  @override
  Widget build(BuildContext context) {
    Widget makeBody() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: audioService!.getRecorderFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(
                    audioService!.mRecorder!.isRecording ? 'Stop' : 'Record'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(audioService!.mRecorder!.isRecording
                  ? 'Recording in progress'
                  : 'Recorder is stopped'),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(3),
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAF0E6),
              border: Border.all(
                color: Colors.indigo,
                width: 3,
              ),
            ),
            child: Row(children: [
              ElevatedButton(
                onPressed: audioService!.getPlaybackFn(),
                //color: Colors.white,
                //disabledColor: Colors.grey,
                child: Text(audioService!.mPlayer!.isPlaying ? 'Stop' : 'Play'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(audioService!.mPlayer!.isPlaying
                  ? 'Playback in progress'
                  : 'Player is stopped'),
            ]),
          ),
        ],
      );
    }

    return Scaffold(
      body: makeBody(),
    );
  }
}
