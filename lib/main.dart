import 'dart:async';

import 'package:flutter/material.dart';
import 'musique.dart';
import 'package:audioplayers/audioplayers.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAS Music',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SAS Music'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Musique> maListDeMusique = [
    new Musique('Theme Swift', 'SAS_DEV', 'assets/record-player.jpg', 'https://codabee.com/wp-content/uploads/2018/06/un.mp3'),
    new Musique('Theme Flutter', 'SAS_DEV', 'assets/hand.jpg', 'https://codabee.com/wp-content/uploads/2018/06/deux.mp3')

  ];

  late Musique maMusiqueActuelle;
  late AudioPlayer audioPlayer;
  late StreamSubscription positionSub;
  late StreamSubscription stateSubscription;

  Duration position = new Duration(seconds: 0);
  Duration duree = new Duration(seconds: 10);
  PlayerState statut = PlayerState.STOPPED;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maMusiqueActuelle = maListDeMusique[0];
    configurationAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Card(
              elevation: 9.0,
              child: new Container(
                width: MediaQuery.of(context).size.height / 2.5,
                child: new Image.asset(maMusiqueActuelle.imagePath),
              ),
            ),
            texteAvecStyle(maMusiqueActuelle.titre, 1.5),
            texteAvecStyle(maMusiqueActuelle.artiste, 1.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                button(Icons.fast_rewind, 30.0, ActionMusic.rewind),
                button(Icons.play_arrow, 45.0, ActionMusic.play),
                button(Icons.fast_forward, 30.0, ActionMusic.forward)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                texteAvecStyle('0:0', 0.8),
                texteAvecStyle('0:22', 0.8)
              ],
            ),
            new Slider(
                value: position.inSeconds.toDouble(),
                min: 0.0,
                max: 30.0,
                inactiveColor: Colors.white,
                activeColor: Colors.red,
                onChanged: (double d) {
                  setState(() {
                    Duration nouvelleDuration = new Duration(seconds: d.toInt());
                    position = nouvelleDuration;
                  });
                }
            ),

          ],
        ),
      ),
      backgroundColor: Colors.grey[800],
    );
  }

  IconButton button(IconData icone, double taille, ActionMusic action) {
    return new IconButton(
      iconSize: taille,
      color: Colors.white,
      onPressed: () {
        switch (action) {
          case (ActionMusic.play):
            print('play');
            break;
          case (ActionMusic.pause):
            print('pause');
            break;
          case (ActionMusic.rewind):
            print('rewind');
            break;
          case (ActionMusic.forward):
            print('forward');
            break;
        }

      },
      icon: new Icon(icone),
    );
  }

  Text texteAvecStyle(String data, double scale)  {
    return new Text(
      data,
      textScaleFactor: scale,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  void configurationAudioPlayer() {
    audioPlayer = new AudioPlayer();
    positionSub = audioPlayer.onAudioPositionChanged.listen(
        (pos) => setState(() => position = pos)
    );
    stateSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      if(state == AudioPlayerState.playing) {
        setState(() {
          duree = audioPlayer.getDuration() as Duration;
        });
      }else {
        if(state == AudioPlayerState.stopped) {
        setState(() {
          statut = PlayerState.STOPPED;
        });
      }
      }
    }, onError: (message) {
      print('erreur: $message');
      setState(() {
        statut = PlayerState.STOPPED;
        duree = new Duration(seconds: 0);
        position = new Duration(seconds: 0);
      });
    }
    );
  }
}

enum ActionMusic {
  play,
  pause,
  rewind,
  forward,
}

enum AudioPlayerState {
  playing,
  stopped,
  paused,
}
