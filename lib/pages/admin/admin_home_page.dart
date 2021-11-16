import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticked/pages/admin/routes/routes_widget.dart';
import 'package:ticked/pages/admin/tickets/tickets_widget.dart';
import 'package:ticked/widgets/menu_widget.dart';

import 'flights/flights_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final myKey = GlobalKey<_AdminHomePageState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const RoutesWidget(),
    const FlightsWidget(),
    const TicketsWidget(),
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
            icon: Icon(Icons.alt_route_outlined),
            label: 'Trasy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active_outlined),
            label: 'Loty',
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
