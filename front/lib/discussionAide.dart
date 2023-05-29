import 'package:flutter/material.dart';
import 'package:front/aide.dart';
import 'package:front/db/db.dart';
import 'package:front/forum.dart';
import 'package:front/guides.dart';
import 'package:front/models/guide.dart';
import 'package:front/models/aide.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';

void main() => runApp(DiscussionAideApp());

class DiscussionAideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aide',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiscussionAidePage(aideId: ''),
    );
  }
}

class DiscussionAidePage extends StatefulWidget {
  final String aideId;

  DiscussionAidePage({required this.aideId});

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionAidePage> {
  Aide? fetchedAide;
  TextEditingController _reponseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAide();
  }

  Future<void> _fetchAide() async {
    var aide = await Database().getAideById(widget.aideId);

    setState(() {
      fetchedAide = aide;
    });
  }

  void _addComment() async {
    String text = _reponseController.text;

    if (text.isEmpty) {
      return;
    }

    await Database().addReponse(text, widget.aideId);

    _reponseController.clear();

    await _fetchAide();
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
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (fetchedAide != null)
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
                                fetchedAide!.utilisateur.avatar.isEmpty
                                    ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                    : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/${fetchedAide!.utilisateur.id}/${fetchedAide!.utilisateur.avatar}',
                              ),
                            ),
                            title: Text(
                              fetchedAide!.titre,
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
                                  'Publié le: ${fetchedAide!.created} par: ${fetchedAide!.utilisateur.username}',
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
                              fetchedAide!.type,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          if (fetchedAide!.reponses.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: fetchedAide!.reponses.length,
                              itemBuilder: (context, index) {
                                var reponse = fetchedAide!.reponses[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      reponse.utilisateur.avatar.isEmpty
                                          ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                          : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/${fetchedAide!.utilisateur.id}/${reponse.utilisateur.avatar}',
                                    ),
                                  ),
                                  title: Text(
                                    reponse.texte,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Par: ${reponse.utilisateur.username} le: ${reponse.created}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ajouter une réponse',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  controller: _reponseController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Entrez votre réponse',
                                  ),
                                  minLines: 3,
                                  maxLines: 5,
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: _addComment,
                                  child: Text('Envoyer'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (fetchedAide == null)
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
