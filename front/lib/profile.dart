import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/inscription.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:pocketbase/pocketbase.dart';

void main() => runApp(ProfileApp());

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page d\'inscription',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Text("Profile"),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(3),
    );
  }
}