import 'dart:io';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart';

///
typedef _Fn = void Function();

const theSource = AudioSource.microphone;

class AudioServices {
  AudioServices() {
    init();
  }

//initializing all the instances of flutter_sound
  Codec _codec = Codec.aacMP4;
  String _mPath = 'leoTest.mp4';
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  init() {
    _mPlayer!.openAudioSession().then((value) {
      _mPlayerIsInited = true;
    });

    openTheRecorder().then((value) {
      _mRecorderIsInited = true;
    });

    getAppDirectory();
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }

    await _mRecorder!.openAudioSession();
    if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
      var appDirectory = await getAppDirectory();
      _codec = Codec.opusWebM;
      _mPath = "$appDirectory/tau_file.webm";
      print("AUDIO==> $_mPath");
      if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
        _mRecorderIsInited = true;
        return;
      }
    }
    _mRecorderIsInited = true;
  }

  getAppDirectory() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    //also update the _mpath
    _mPath = "$appDocPath/testAudio.mp4";
    print("Audio File path is ===>  $_mPath");
    return appDocPath;
  }
  // ----------------------  Here is the code for recording and playback -------

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: _mPath,
      codec: _codec,
      audioSource: theSource,
    )
        .then((value) {
      // setState(() {});
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      // setState(() {
      //var url = value;
      _mplaybackReady = true;
      // });
    });
  }

  void play() async {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    print("Audio FIle mp4 path is ======> $_mPath");
    // File audioFile = File('$appDocPath/$_mPath');
    _mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {})
        .then((value) {});
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {});
  }

//defining methods for performing some sound operations in generic way
/**
 * record()
 * 
 * play()
 * 
 * stop(),
 * 
 * disposeRecorder(),
 * 
 * stopPlayer(),
 * 
 * 
 stopRecorder(),
 * 
 * 
 */

}
