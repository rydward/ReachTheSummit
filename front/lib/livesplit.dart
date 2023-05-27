import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front/addSpeedrun.dart';
import 'package:front/speedrun.dart';
import 'package:intl/intl.dart';

import 'db/db.dart';

void main() => runApp(SpeedrunApp());

class SpeedrunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speedruns',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LivesplitPage(),
    );
  }
}

class LivesplitPage extends StatefulWidget {
  @override
  _LivesplitPageState createState() => _LivesplitPageState();
}

class _LivesplitPageState extends State<LivesplitPage> {
  List<String> levels = [
    'Prologue',
    'Forsaken City',
    'Old Site',
    'Celestial Resort',
    'Golden Ridge',
    'Mirror Temple',
    'Reflection',
    'The Summit',
  ];
  List<int> levelTimes = List<int>.filled(8, 0);
  int currentLevelIndex = 0;
  Stopwatch stopwatch = Stopwatch();
  bool isRunning = false;
  Timer? timer;
  int totalTime = 0;
  String totalTimeString = '';
  bool isLastLevel = false;

  @override
  void dispose() {
    stopwatch.stop();
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    stopwatch.start();
    setState(() {
      isRunning = true;
    });

    timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) {
      setState(() {
        // Mise à jour du chronomètre dans l'interface utilisateur
      });
    });
  }

  void stopTimer() {
    stopwatch.stop();
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    Database().addLivesplit(totalTime, levelTimes[0], levelTimes[1], levelTimes[2], levelTimes[3], levelTimes[4], levelTimes[5], levelTimes[6], levelTimes[7]);

    stopwatch.reset();
    levelTimes = List<int>.filled(8, 0);
    currentLevelIndex = 0;
    timer?.cancel();
    setState(() {
      isRunning = false;
      totalTime = 0;
      totalTimeString = '';
      isLastLevel = false;
    });
  }

  void recordLevelTime() {
    if (currentLevelIndex < 7) {
      levelTimes[currentLevelIndex] = stopwatch.elapsed.inSeconds;
      currentLevelIndex++;
      stopwatch.reset();
      stopwatch.start();
    } else {
      stopwatch.stop();
      levelTimes[currentLevelIndex] = stopwatch.elapsed.inSeconds;
      totalTime = levelTimes.reduce((value, element) => value + element);
      totalTimeString = formatTime(totalTime * 1000);
      isLastLevel = true;
    }
  }


  String formatTime(int milliseconds) {
    final Duration duration = Duration(milliseconds: milliseconds);
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpeedrunPage()),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddSpeedrunPage()),
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
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: screenSize.height * 0.4, // Hauteur de la moitié supérieure de l'écran
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Temps total',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          totalTimeString,
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          levels[currentLevelIndex],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        if (isRunning)
                          Text(
                            formatTime(stopwatch.elapsed.inMilliseconds),
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          ),
                        SizedBox(height: 20),
                        if (!isRunning)
                          ElevatedButton(
                            onPressed: () => startTimer(),
                            child: Text('Start'),
                          ),
                        if (isRunning)
                          if (isLastLevel)
                            ElevatedButton(
                              onPressed: () => resetTimer(),
                              child: Text('Terminer'),
                            )
                          else
                            ElevatedButton(
                              onPressed: () => recordLevelTime(),
                              child: Text('Next Level'),
                            ),
                        if (isRunning)
                          ElevatedButton(
                            onPressed: () => stopTimer(),
                            child: Text('Stop'),
                          ),
                        if (!isRunning && currentLevelIndex > 0)
                          ElevatedButton(
                            onPressed: () => resetTimer(),
                            child: Text('Reset'),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Level')),
                          DataColumn(label: Text('Time')),
                        ],
                        rows: List<DataRow>.generate(
                          levelTimes.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text(levels[index])),
                              DataCell(Text(formatTime(levelTimes[index].toInt() * 1000))), // Convertir en millisecondes pour rester cohérent avec la valeur actuelle
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
