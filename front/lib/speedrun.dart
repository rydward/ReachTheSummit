import 'package:flutter/material.dart';
import 'package:front/livesplit.dart';
import 'package:front/models/users.dart';
import 'package:intl/intl.dart';
import 'package:front/db/db.dart';
import 'package:front/models/speedrun.dart';
import 'package:front/AddSpeedrun.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() => runApp(SpeedrunApp());

class SpeedrunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedruns',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpeedrunPage(),
    );
  }
}

class SpeedrunPage extends StatefulWidget {
  @override
  _SpeedrunPageState createState() => _SpeedrunPageState();
}

class _SpeedrunPageState extends State<SpeedrunPage> {
  List<Speedrun> verifiedSpeedruns = [];
  List<Speedrun> speedrunsToVerify = [];
  Users? user;

  @override
  void initState() {
    super.initState();
    _fetchSpeedRuns();
    _getConnectedUser();
  }

  Future<void> _fetchSpeedRuns() async {
    var fetchedVerifiedSpeedruns = await Database().getVerifiedSpeedRuns();
    var fetchedSpeedrunsToVerify = await Database().getSpeedrunsToVerify();

    setState(() {
      verifiedSpeedruns = fetchedVerifiedSpeedruns;
      speedrunsToVerify = fetchedSpeedrunsToVerify;
    });
  }

  Future<void> _getConnectedUser() async {
    user = await Database().getConnectedUser();

    setState(() {
      user = user;
    });
  }

  String formatTime(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    return DateFormat.Hms().format(DateTime(0, 0, 0).add(duration));
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
                      'Speedrun',
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
                        MaterialPageRoute(builder: (context) => AddSpeedrun()),
                      );
                    },
                    child: Text(
                      'Ajouter une run',
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
                        MaterialPageRoute(builder: (context) => LivesplitPage()),
                      );
                    },
                    child: Text(
                      'Livesplit',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white, // Fond blanc
                  child: Column(
                    children: [
                      if (verifiedSpeedruns.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('')),
                              DataColumn(label: Text('Joueur')),
                              DataColumn(label: Text('IGT')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Plateforme')),
                              DataColumn(label: Text('Version')),
                              DataColumn(label: Text('Vidéo')),
                            ],
                            rows: verifiedSpeedruns
                                .map(
                                  (speedrun) => DataRow(
                                    cells: [
                                      DataCell(
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                            speedrun.createur.avatar.isEmpty
                                                ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                                : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${speedrun.createur.avatar}',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            Text(speedrun.createur.username),
                                            SizedBox(width: 5),
                                            if (speedrun.note.isNotEmpty)
                                              Tooltip(
                                                message: speedrun.note,
                                                child: Container(
                                                  width: 16,
                                                  height: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      DataCell(
                                        Text(formatTime(speedrun.igt)),
                                      ),
                                      DataCell(
                                        Text(speedrun.created),
                                      ),
                                      DataCell(
                                        Text(speedrun.plateforme),
                                      ),
                                      DataCell(
                                        Text(speedrun.version),
                                      ),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.play_arrow),
                                          onPressed: () => launchUrl(Uri.parse(speedrun.video)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      if (speedrunsToVerify.isNotEmpty && user?.role == 'verificateur')
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: [
                              DataColumn(label: Text('')),
                              DataColumn(label: Text('Joueur')),
                              DataColumn(label: Text('IGT')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Plateforme')),
                              DataColumn(label: Text('Version')),
                              DataColumn(label: Text('Vidéo')),
                              DataColumn(label: Text('Valider')),
                              DataColumn(label: Text('Refuser')),
                            ],
                            rows: speedrunsToVerify
                                .map(
                                  (speedrun) => DataRow(
                                    cells: [
                                      DataCell(
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                            speedrun.createur.avatar.isEmpty
                                                ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                                : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${speedrun.createur.avatar}',
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            Text(speedrun.createur.username),
                                            SizedBox(width: 5),
                                            if (speedrun.note.isNotEmpty)
                                              Tooltip(
                                                message: speedrun.note,
                                                child: Container(
                                                  width: 16,
                                                  height: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      DataCell(
                                        Text(formatTime(speedrun.igt)),
                                      ),
                                      DataCell(
                                        Text(speedrun.created),
                                      ),
                                      DataCell(
                                        Text(speedrun.plateforme),
                                      ),
                                      DataCell(
                                        Text(speedrun.version),
                                      ),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.play_arrow),
                                          onPressed: () => launchUrl(Uri.parse(speedrun.video)),
                                        ),
                                      ),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: () {
                                            Database().verifySpeedrun(speedrun.id, true);
                                            _fetchSpeedRuns();
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Database().verifySpeedrun(speedrun.id, false);
                                            _fetchSpeedRuns();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}
