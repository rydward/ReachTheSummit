import 'package:flutter/material.dart';
import 'package:front/aide.dart';
import 'package:front/db/db.dart';
import 'package:front/forum.dart';
import 'package:front/guides.dart';
import 'package:front/models/guide.dart';
import 'package:front/models/sujet.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';

void main() => runApp(DiscussionApp());

class DiscussionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guides',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiscussionPage(sujetId: ''),
    );
  }
}

class DiscussionPage extends StatefulWidget {
  final String sujetId;

  DiscussionPage({required this.sujetId});

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  Sujet? fetchedSujet;

  @override
  void initState() {
    super.initState();
    _fetchGuide();
  }

  Future<void> _fetchGuide() async {
    var sujet = await Database().getSujetById(widget.sujetId);

    setState(() {
      fetchedSujet = sujet;
    });
  }

  void _handleGuideTap(Guide guide) {
    print('Guide tapped: ${guide.titre}');
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
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForumPage()),
                      );
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
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (fetchedSujet != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                fetchedSujet!.utilisateur.avatar.isEmpty
                                    ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                    : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${fetchedSujet!.utilisateur.avatar}',
                              ),
                            ),
                            title: Text(
                              fetchedSujet!.titre,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4),
                                Text(
                                  'Publié le: ${fetchedSujet!.created} par: ${fetchedSujet!.utilisateur.username}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              fetchedSujet!.texte,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (fetchedSujet!.commentaires.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: fetchedSujet!.commentaires.length,
                              itemBuilder: (context, index) {
                                var commentaire = fetchedSujet!.commentaires[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      commentaire.utilisateur.avatar.isEmpty
                                          ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                          : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${commentaire.utilisateur.avatar}',
                                    ),
                                  ),
                                  title: Text(
                                    commentaire.texte,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Par: ${commentaire.utilisateur.username} le: ${commentaire.created}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (fetchedSujet == null)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(1),
    );
  }
}
