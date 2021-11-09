import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticked/pages/settings/settings_page.dart';
import 'package:ticked/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

    const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
      Text(
        'Index 1: Rezerwacje',
        style: optionStyle,
      ),
      Text(
        'Index 2: Bilety',
        style: optionStyle,
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'TICKED',
          style: GoogleFonts.jetBrainsMono(
              textStyle: const TextStyle(color: Colors.white, fontSize: 30)),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              label: const Text(
                '',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Center(child: Text('${snapshot.data!['role']}'));
          }
          return const LinearProgressIndicator();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_outlined),
            label: 'Rezerwacje',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_rounded),
            backgroundColor: Colors.black,
            label: 'Bilety',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: Colors.amber[900],
        onTap: _onItemTapped,
      ),
    );
  }
}
