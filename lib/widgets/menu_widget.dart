import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticked/services/auth_service.dart';
import 'package:ticked/utils/authentication_wrapper.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthenticationWrapper(),
                    ),
                    (route) => false,
                  );
                },
                child: const SizedBox(
                  width: 170,
                  height: 170,
                  child: Text('wyloguj się'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: const SizedBox(
                  width: 170,
                  height: 170,
                  child: Text('dane użytkownika'),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: const SizedBox(
                  width: 170,
                  height: 170,
                  child: Text('trasy'),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: const SizedBox(
                  width: 170,
                  height: 170,
                  child: Text('bilety'),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
