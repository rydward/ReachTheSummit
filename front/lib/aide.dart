import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/models/actualite.dart';
import 'package:front/discussionAide.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';
import 'package:front/models/aide.dart';

import 'forum.dart';
import 'guides.dart';

void main() => runApp(AideApp());

class AideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AidePage(),
    );
  }
}

class AidePage extends StatefulWidget {
  @override
  _AidePageState createState() => _AidePageState();
}

class _AidePageState extends State<AidePage> {
  List<Aide> aides = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAides();
  }

  Future<void> _fetchAides() async {
    var fetchedAides = await Database().getAides();

    setState(() {
      aides = fetchedAides;
    });
  }

  void _handleAideTap(Aide aide) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DiscussionAidePage(aideId: aide.id)),
    );
  }

  void _addAide() async {
    String title = _titleController.text;
    String text = _textController.text;

    if (title.isEmpty || text.isEmpty) {
      return;
    }

    await Database().addAide(title, text);

    _titleController.clear();
    _textController.clear();

    await _fetchAides();
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
                        MaterialPageRoute(builder: (context) => GuidesPage()),
                      );
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
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AidePage()),
                      );
                    },
                    child: Text(
                      'Aide',
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
                            'Ajouter un sujet de discussion',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Titre du sujet',
                              fillColor: Colors.white,  // Set the background color to white
                              filled: true,  // Enable filling the background color
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: _textController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Texte du sujet',
                              fillColor: Colors.white,  // Set the background color to white
                              filled: true,  // Enable filling the background color
                            ),
                            minLines: 3,
                            maxLines: 5,
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _addAide,
                            child: Text('Ajouter'),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: aides.map((aide) {
                        return GestureDetector(
                          onTap: () => _handleAideTap(aide),
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20, // Reduce the size of the avatar
                                backgroundImage: NetworkImage(
                                  aide.utilisateur.avatar.isEmpty
                                      ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                      : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${aide.utilisateur.avatar}',
                                ),
                              ),
                              title: Text(
                                aide.titre,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4),
                                  Text(
                                    'Publié le: ${aide.created}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                aide.utilisateur.username,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
