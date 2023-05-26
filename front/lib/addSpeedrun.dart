import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/discussion.dart';
import 'package:front/models/actualite.dart';
import 'package:front/models/sujet.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:front/speedrun.dart';
import 'package:intl/intl.dart';

import 'aide.dart';
import 'guides.dart';
import 'models/users.dart';

void main() => runApp(AddSpeedrun());

class AddSpeedrun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AddSpeedrun',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddSpeedrunPage(),
    );
  }
}

class AddSpeedrunPage extends StatefulWidget {
  @override
  _AddSpeedrunPageState createState() => _AddSpeedrunPageState();
}

class _AddSpeedrunPageState extends State<AddSpeedrunPage> {
  TextEditingController _linkController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _plateformeController = TextEditingController();
  TextEditingController _versionController = TextEditingController();
  TextEditingController _igtController = TextEditingController();


  void _handleSubjectTap(Sujet sujet) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiscussionPage(sujetId: sujet.id)),
    );
  }

  void _addSubject() async {
    String link = _linkController.text;
    String note = _noteController.text;
    String plateforme = _plateformeController.text;
    String version = _versionController.text;
    String igt = _igtController.text;

    if (link.isEmpty || note.isEmpty || plateforme.isEmpty || version.isEmpty || igt.isEmpty) {
      return;
    }

    await Database().AddSpeedrun(link, note, plateforme, version, igt);

    _linkController.clear();
    _noteController.clear();
    _plateformeController.clear();
    _versionController.clear();
    _igtController.clear();

  }

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpeedrunApp()),
                      );
                    },
                    child: Text(
                      'Speedrun',
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
                      '+ Speedrun',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ajouter un Speedrun',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _linkController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Lien vidéo',
                              fillColor: Colors.white,  // Set the background color to white
                              filled: true,  // Enable filling the background color
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _noteController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'note',
                              fillColor: Colors.white,  // Set the background color to white
                              filled: true,  // Enable filling the background color
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _plateformeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'plateforme',
                              fillColor: Colors.white,  // Set the background color to white
                              filled: true,  // Enable filling the background color
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _versionController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'version',
                              fillColor: Colors.white,  // Set the background color to white
                              filled: true,  // Enable filling the background color
                            ),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _igtController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'igt',
                              fillColor: Colors.white,  // Set the background color to white
                              filled: true,  // Enable filling the background color
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _addSubject,
                            child: Text('Ajouter'),
                          ),
                        ],
                      ),
                    ),
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
