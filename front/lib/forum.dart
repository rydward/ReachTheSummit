import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/discussion.dart';
import 'package:front/models/actualite.dart';
import 'package:front/models/sujet.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';

import 'aide.dart';
import 'guides.dart';
import 'models/users.dart';

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
  List<Sujet> subjects = [];

  @override
  void initState() {
    super.initState();
    _fetchSubjects();
  }

  Future<void> _fetchSubjects() async {
    var fetchedSubjects = await Database().getSubjects();

    setState(() {
      subjects = fetchedSubjects;
    });
  }

    void _handleSubjectTap(Sujet sujet) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DiscussionPage(sujetId: sujet.id)),
      );
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
                children: subjects.map((sujet) {
                  return GestureDetector(
                    onTap: () => _handleSubjectTap(sujet),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,  // Reduce the size of the avatar
                          backgroundImage: NetworkImage(
                            sujet.utilisateur.avatar.isEmpty
                                ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${sujet.utilisateur.avatar}',
                          ),
                        ),
                        title: Text(
                          sujet.titre,
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
                              'Publié le: ${sujet.created}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          sujet.utilisateur.username,
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
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: BottomNavigationBarWidget(1),
  );
}

}
