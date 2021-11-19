import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticked/pages/user/flights/search_flight.dart';
import 'package:ticked/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final myKey = GlobalKey<_HomePage>();
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
    //const RoutesWidget(),
    const Text(
      'Index 2: Rezerwacje',
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
      key: myKey,
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
      ),
      body: SingleChildScrollView(
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
