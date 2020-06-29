import 'package:app/util/playstate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class NormalSong extends ChangeNotifier{
    factory NormalSong() {
    if (_this == null) _this = NormalSong._();
    return _this;
  }
  static NormalSong _this;
  NormalSong._() : super();
  AudioPlayer audioPlayer;
  PlayerState playerState = PlayerState.stopped;
  get isPlaying => playerState == PlayerState.playing;

  Future<int> play(String url) async {
    final result = await audioPlayer.play(url);
    if (result == 1){
      playerState = PlayerState.playing;
     notifyListeners();
    }
    return result;
  }

  Future<int> pause() async {
    final result = await audioPlayer.pause();
    if (result == 1){
      playerState = PlayerState.paused;
      notifyListeners();
    }
    return result;
  }
}