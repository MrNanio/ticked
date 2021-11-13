import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticked/pages/flights/search_flight.dart';
import 'package:ticked/pages/settings/settings_page.dart';
import 'package:ticked/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = <Widget>[
    const SearchFlight(),
    const Text(
      'Index 1: Rezerwacje',
      style: optionStyle,
    ),
    const Text(
      'Index 2: Bilety',
      style: optionStyle,
    ),
    const MenuWidget()
  ];

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
            label: 'Bilety',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
}
