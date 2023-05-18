import 'package:flutter/material.dart';
import 'package:front/accueil.dart';
import 'package:front/guides.dart';
import 'package:front/profile.dart';
import 'package:front/speedrun.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int currentIndex;

  BottomNavigationBarWidget(this.currentIndex);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends State<BottomNavigationBarWidget> {
  List<IconData> _icons = [
    Icons.home,
    Icons.chat,
    Icons.access_time,
    Icons.person,
  ];

  List<Color> _iconColors = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];

  List<Color> _activeIconColors = [
    Colors.lightBlue,
    Colors.lightBlue,
    Colors.lightBlue,
    Colors.lightBlue,
  ];

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AccueilPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => GuidesPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SpeedrunPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.lightBlue,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          widget.currentIndex = index;
        });
        navigateToPage(index);
      },
      items: _icons.map((icon) {
        int index = _icons.indexOf(icon);
        return BottomNavigationBarItem(
          icon: Icon(
            icon,
            color: widget.currentIndex == index
                ? _activeIconColors[index]
                : _iconColors[index],
          ),
          label: '',
        );
      }).toList(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: Text('Chat Page'),
      ),
    );
  }
}

class TimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time'),
      ),
      body: Center(
        child: Text('Time Page'),
      ),
    );
  }
}

class PersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person'),
      ),
      body: Center(
        child: Text('Person Page'),
      ),
    );
  }
}
