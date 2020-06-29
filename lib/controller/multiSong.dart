import 'package:app/util/playstate.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class MultiSong extends ChangeNotifier{
    factory MultiSong() {
    if (_this == null) _this = MultiSong._();
    return _this;
  }
  static MultiSong _this;
  MultiSong._() : super();
  AudioPlayer audioPlayer1;
  AudioPlayer audioPlayer2;
  PlayerState playerState1 = PlayerState.stopped;
   PlayerState playerState2 = PlayerState.stopped;
  get isPlaying1 => playerState1 == PlayerState.playing;
   get isPlaying2 => playerState2 == PlayerState.playing;


  Future<int> play1(String url) async {
    final result = await audioPlayer1.play(url);
    if (result == 1){
      playerState1 = PlayerState.playing;
     notifyListeners();
    }
    return result;
  }

  Future<int> pause1() async {
    final result = await audioPlayer1.pause();
    if (result == 1){
      playerState1 = PlayerState.paused;
      notifyListeners();
    }
    return result;
  }
    Future<int> play2(String url) async {
    final result = await audioPlayer2.play(url);
    if (result == 1){
      playerState2 = PlayerState.playing;
     notifyListeners();
    }
    return result;
  }

  Future<int> pause2() async {
    final result = await audioPlayer2.pause();
    if (result == 1){
      playerState2 = PlayerState.paused;
      notifyListeners();
    }
    return result;
  }
}