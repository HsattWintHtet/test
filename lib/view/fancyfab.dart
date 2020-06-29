import 'package:app/controller/multiSong.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FancyFab extends StatefulWidget {
  final String song1;
  final String song2;

  const FancyFab({Key key, this.song1, this.song2}) : super(key: key);
  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  // Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  final songControl = MultiSong();

  @override
  initState() {
    songControl.audioPlayer1 = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    songControl.audioPlayer2 = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    songControl.audioPlayer1.stop();
    songControl.audioPlayer2.stop();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget song1() {
    final song = Provider.of<MultiSong>(context);
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
        child: IconButton(
          icon: song.isPlaying1 ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: song.isPlaying2
              ? () {}
              : song.isPlaying1
                  ? () => song.pause1()
                  : () => song.play1(widget.song1),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
      ),
    );
  }

  Widget song2() {
    final song = Provider.of<MultiSong>(context);
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
        child: IconButton(
          icon: song.isPlaying2 ? Icon(Icons.pause) : Icon(Icons.play_arrow),
          onPressed: song.isPlaying1
              ? () {}
              : song.isPlaying2
                  ? () => song.pause2()
                  : () => song.play2(widget.song2),
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white,
        onPressed: animate,
        // tooltip: 'Toggle',
        child: AnimatedIcon(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.black,
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: song1(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: song2(),
        ),
        toggle(),
      ],
    );
  }
}
