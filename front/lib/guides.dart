import 'package:flutter/material.dart';
import 'package:front/aide.dart';
import 'package:front/db/db.dart';
import 'package:front/forum.dart';
import 'package:front/models/guide.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:intl/intl.dart';

import 'guide.dart';

void main() => runApp(GuidesApp());

class GuidesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guides',
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
  
  List<Guide> guides = [];

  @override
  void initState() {
    super.initState();
    _fetchGuides();
  }

  Future<void> _fetchGuides() async {
    var fetchedGuides = await Database().getGuides();

    setState(() {
      guides = fetchedGuides;
    });
  }

  void _handleGuideTap(Guide guide) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GuidePage(guideId: guide.id)),
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
                      // Rien à faire, on est déjà sur la page
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: guides.map((guide) {
                    return GestureDetector(
                      onTap: () => _handleGuideTap(guide),
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,  // Reduce the size of the avatar
                            backgroundImage: NetworkImage(
                              guide.createur.avatar.isEmpty
                                  ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                  : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/${guide.createur.id}/${guide.createur.avatar}',
                            ),
                          ),
                          title: Text(
                            guide.titre,
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
                                'Publié le: ${guide.created}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            guide.createur.username,
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
