import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/inscription.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:pocketbase/pocketbase.dart';

void main() => runApp(SpeedrunApp());

class SpeedrunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page d\'inscription',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpeedrunPage(),
    );
  }
}

class SpeedrunPage extends StatefulWidget {
  @override
  _SpeedrunPageState createState() => _SpeedrunPageState();
}

class _SpeedrunPageState extends State<SpeedrunPage> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Text("Speedrun"),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}