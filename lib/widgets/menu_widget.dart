import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticked/pages/admin/admin_home_page.dart';
import 'package:ticked/services/auth_service.dart';
import 'package:ticked/utils/authentication_wrapper.dart';

import 'package:styled_widget/styled_widget.dart';
import 'package:division/division.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final AuthService _auth = AuthService();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    if (_auth.uid == 'Z8GIyyWlyLgODSZ5CP3njjtNBEz2') {
      isVisible = true;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        <Widget>[
          Row(
            children: [
              const Icon(Icons.account_circle)
                  .decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  )
                  .constrained(height: 50, width: 50)
                  .padding(right: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(_auth.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Text(
                            '${snapshot.data!['email']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ).padding(bottom: 5);
                        }
                        return const LinearProgressIndicator();
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(_auth.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return Text(
                            '${snapshot.data!['role']}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          );
                        }
                        return const LinearProgressIndicator();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text("0")
                      .fontSize(20)
                      .textColor(Colors.white)
                      .padding(bottom: 5),
                  const Text("Rezerwacje")
                      .textColor(Colors.white.withOpacity(0.6))
                      .fontSize(12),
                ],
              ),
              Column(
                children: [
                  const Text("0")
                      .fontSize(20)
                      .textColor(Colors.white)
                      .padding(bottom: 5),
                  const Text("Obserwowane")
                      .textColor(Colors.white.withOpacity(0.6))
                      .fontSize(12),
                ],
              ),
              Column(
                children: [
                  const Text("0")
                      .fontSize(20)
                      .textColor(Colors.white)
                      .padding(bottom: 5),
                  const Text("Anulowane")
                      .textColor(Colors.white.withOpacity(0.6))
                      .fontSize(12),
                ],
              )
            ],
          )
        ]
            .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
            .padding(horizontal: 20, vertical: 10)
            .decorated(
                color: Colors.indigo, borderRadius: BorderRadius.circular(20))
            .elevation(
              5,
              shadowColor: const Color(0xff1c2e49),
              borderRadius: BorderRadius.circular(20),
            )
            .height(175)
            .alignment(Alignment.center),
        const SizedBox(height: 10),
        Visibility(
          visible: isVisible,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminHomePage(),
                  ),
                );
              },
              child: Column(
                children: [
                  const Icon(Icons.add_location_alt_outlined,
                          size: 20, color: Color(0xFF42526F))
                      .alignment(Alignment.center)
                      .ripple()
                      .constrained(width: 50, height: 50)
                      .backgroundColor(const Color(0xfff6f5f8))
                      .clipOval()
                      .padding(bottom: 5),
                  Text(
                    "Trasy",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ).padding(vertical: 20),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  const Icon(Icons.airplane_ticket_outlined,
                          size: 20, color: Color(0xFF42526F))
                      .alignment(Alignment.center)
                      .ripple()
                      .constrained(width: 50, height: 50)
                      .backgroundColor(const Color(0xfff6f5f8))
                      .clipOval()
                      .padding(bottom: 5),
                  Text(
                    "Loty",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ).padding(vertical: 20),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  const Icon(Icons.playlist_add_outlined,
                          size: 20, color: Color(0xFF42526F))
                      .alignment(Alignment.center)
                      .ripple()
                      .constrained(width: 50, height: 50)
                      .backgroundColor(const Color(0xfff6f5f8))
                      .clipOval()
                      .padding(bottom: 5),
                  Text(
                    "Bilety",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ).padding(vertical: 20),
            ),
            InkWell(
              onTap: () {},
              child: Column(
                children: [
                  const Icon(Icons.approval, size: 20, color: Color(0xFF42526F))
                      .alignment(Alignment.center)
                      .ripple()
                      .constrained(width: 50, height: 50)
                      .backgroundColor(const Color(0xfff6f5f8))
                      .clipOval()
                      .padding(bottom: 5),
                  Text(
                    "Rezerwacje",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ).padding(vertical: 20),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () {
              setState(() => isVisible = true);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Parent(
                    style: settingsItemIconStyle(Colors.brown),
                    child: const Icon(Icons.account_box,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Moje dane",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 5),
                      Text("zobacz swoje dane ",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () {
              setState(() => isVisible = false);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Parent(
                    style: settingsItemIconStyle(Colors.deepPurple),
                    child: const Icon(Icons.location_city_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Moje adresy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 5),
                      Text("zobacz i zmień swój adres",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Parent(
                    style: settingsItemIconStyle(Colors.blueGrey),
                    child: const Icon(Icons.my_library_books,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Warunki korzystania",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 5),
                      Text("zobacz regulamin i warunki korzystania",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: InkWell(
            customBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Parent(
                    style: settingsItemIconStyle(Colors.black38),
                    child:
                        const Icon(Icons.lock, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text("Wyloguj się",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 5),
                      Text("możesz wylogować się z aplikacji",
                          style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  settingsItemIconStyle(Color color) {
    return ParentStyle()
      ..background.color(color)
      ..margin(left: 15)
      ..padding(all: 12)
      ..margin(vertical: 10)
      ..borderRadius(all: 30);
  }
}
