import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/models/actualite.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';

import 'aide.dart';
import 'guides.dart';

void main() => runApp(ForumApp());

class ForumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ForumPage(),
    );
  }
}

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Image6.png'),
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.75),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GuidesPage()));
                    },
                    child: Text(
                      'Guides',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Rien à faire, on est déjà sur la page
                    },
                    child: Text(
                      'Forum',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AidePage()));
                    },
                    child: Text(
                      'Aide',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Your content goes here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(1),
    );
  }
}
