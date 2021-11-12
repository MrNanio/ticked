import 'package:flutter/material.dart';
import 'package:ticked/services/auth_service.dart';
import 'package:ticked/utils/authentication_wrapper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Ustawienia'),
          backgroundColor: Colors.indigo,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shadowColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    alignment: const Alignment(-1,
                        0) // double.infinity is the width and 30 is the height
                    ),
                icon: const Icon(
                  Icons.account_box,
                  color: Colors.black,
                  size: 24.0,
                ),
                label: const Text(
                  'edycja danych użytkonika',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 5),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shadowColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    alignment: const Alignment(-1, 0)),
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                  size: 24.0,
                ),
                label: const Text(
                  'wyloguj',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthenticationWrapper(),
                    ),
                    (route) => false,
                  );
                },
              )
            ]),
          ],
        ));
  }
}
