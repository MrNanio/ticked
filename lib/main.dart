import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ticked/pages/user/flights/flight_tile.dart';
import 'package:ticked/pages/user/flights/search_flight.dart';
import 'package:ticked/pages/user/flights/searched_flight_list.dart';
import 'package:ticked/pages/user/tickets/ticket_book_widget.dart';
import 'package:ticked/services/auth_service.dart';
import 'package:ticked/utils/splash.dart';

import 'models/custom_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
        value: AuthService().customUser,
        initialData: null,
        child: MaterialApp(
            title: 'Ticked',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('pl')
            ],
            home: const Splash(),
          routes: {
            SearchFlight.routeName: (context) =>
              const SearchedFlightList(),
            FlightTile.routeName : (context) =>
                const TicketBookWidget()
          },
        )
    );
  }
}
