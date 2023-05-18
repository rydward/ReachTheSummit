import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/inscription.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:pocketbase/pocketbase.dart';

void main() => runApp(GuidesApp());

class GuidesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page d\'inscription',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuidesPage(),
    );
  }
}

class GuidesPage extends StatefulWidget {
  @override
  _GuidesPageState createState() => _GuidesPageState();
}

class _GuidesPageState extends State<GuidesPage> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Text("Guides"),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(1),
    );
  }
}