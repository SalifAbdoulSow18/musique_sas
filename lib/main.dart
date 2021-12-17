import 'package:flutter/material.dart';
import 'musique.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maMusiqueActuelle = maListDeMusique[0];
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                texteAvecStyle('0:0', 0.8),
                texteAvecStyle('0:22', 0.8)
              ],
            )

          ],
        ),
      ),
      backgroundColor: Colors.grey[800],
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
}
