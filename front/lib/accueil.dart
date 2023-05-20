import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/models/actualite.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';

void main() => runApp(AccueilApp());

class AccueilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page d\'inscription',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccueilPage(),
    );
  }
}

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  List<Actualite> actualites = [];

  @override
  void initState() {
    super.initState();
    _fetchActualites();
  }

  Future<void> _fetchActualites() async {
    var fetchedActualites = await Database().getActualites();

    setState(() {
      actualites = fetchedActualites;
    });
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
        child: ListView.builder(
          itemCount: actualites.length,
          itemBuilder: (BuildContext context, int index) {
            var actualite = actualites[index];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,  // Reduce the size of the avatar
                  backgroundImage: NetworkImage(
                    actualite.createur.avatar.isEmpty
                        ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                        : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${actualite.createur.avatar}',
                  ),
                ),
                title: Text(
                  actualite.titre,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actualite.texte,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Publié le: ${actualite.created}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  actualite.createur.username,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(0),
    );
  }
}
