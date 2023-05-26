import 'package:flutter/material.dart';
import 'package:front/db/db.dart';
import 'package:front/models/speedrun.dart';
import 'package:front/AddSpeedrun.dart';
import 'package:front/share/bottom_navigation_bar_widget.dart';
void main() => runApp(SpeedrunApp());

class SpeedrunApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedruns',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SpeedrunPage(),
    );
  }
}

class SpeedrunPage extends StatefulWidget {

  @override
  _SpeedrunPageState createState() => _SpeedrunPageState();
}

class _SpeedrunPageState extends State<SpeedrunPage> {

  List<Speedrun> speedruns = [];

  @override
  void initState() {
    super.initState();
    _fetchSpeedRuns();
  }

  Future<void> _fetchSpeedRuns() async {
    var fetchedSpeedruns = await Database().getSpeedRuns();

    setState(() {
      speedruns = fetchedSpeedruns;
    });
  }

  void _handleSpeedrunTap(Speedrun speedrun) {
    print('Speedrun: ${speedrun.note}');
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
                      '+ speedrun',
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
                  children: speedruns.map((speedrun) {
                    return GestureDetector(
                      onTap: () => _handleSpeedrunTap(speedrun),
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,  // Reduce the size of the avatar
                            backgroundImage: NetworkImage(
                              speedrun.createur.avatar.isEmpty
                                  ? 'https://cdn-icons-png.flaticon.com/512/6386/6386976.png'
                                  : 'http://127.0.0.1:8090/api/files/_pb_users_auth_/kqtl5vuixxmfxqo/${speedrun.createur.avatar}',
                            ),
                          ),
                          title: Text(
                            speedrun.plateforme + ' - ' + speedrun.version + '\n' + speedrun.note,
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
                                'Publié le: ${speedrun.created}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          trailing: Text(
                            speedrun.createur.username,
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
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}