import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticked/models/airport.dart';
import 'package:ticked/models/custom_user.dart';
import 'package:ticked/models/route.dart';
import 'package:uuid/uuid.dart';

class RouteService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference airportCollection =
      FirebaseFirestore.instance.collection('airports');
  final CollectionReference routesCollection =
      FirebaseFirestore.instance.collection('routes');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference flightsCollection =
      FirebaseFirestore.instance.collection('flights');

  Future addRoute(String fromIata, String toIata) async {
    //give user and airlinie data
    var documentSnapshot = await userCollection
        .where('email', isEqualTo: _auth.currentUser!.email)
        .get();
    var map = (documentSnapshot.docs[0].data() as Map<String, dynamic>);
    var customUser = CustomUser.fromMap(map);
    //give start airport
    var fromAirport = await airportCollection
        .where('iata_code', isEqualTo: fromIata)
        .get();
    var mapAirportFrom = (fromAirport.docs[0].data() as Map<String, dynamic>);
    var startAirport = Airport.fromMap(mapAirportFrom);
    //give end airport
    var toAirport =
        await airportCollection.where('iata_code', isEqualTo: toIata).get();
    var mapAirportTo = (toAirport.docs[0].data() as Map<String, dynamic>);
    var destAirport = Airport.fromMap(mapAirportTo);
    //give uid
    var uuid = const Uuid();

    await routesCollection.add({
      'route_code': uuid.v4(),
      'airline_code': customUser.airlineCode,
      'from_iata': fromIata,
      'from_city': startAirport.city,
      'from_country': startAirport.country,
      'to_iata': toIata,
      'to_city': destAirport.city,
      'to_country': destAirport.country
    });
  }

  Stream<List<Route>> getRoutes() {
    return routesCollection
        // .where('airlines_code', isEqualTo: airlinesCode)
        .snapshots()
        .map(_routesListFromSnapshot);
  }

  List<Route> _routesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Route.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Route>> getRouteListByIataCodes(String fromIata, String toIata) {
    return routesCollection
        .where('from_iata', isEqualTo: fromIata)
        .where('to_iata', isEqualTo: toIata)
        .snapshots()
        .map(_routeListFromSnapshot);
  }

  List<Route> _routeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Route(
          routeCode: doc.get('route_code') ?? '',
          airlineCode: doc.get('airline_code') ?? '',
          fromIata: doc.get('from_iata') ?? '',
          fromCity: doc.get('from_city') ?? '',
          fromCountry: doc.get('from_country') ?? '',
          toIata: doc.get('to_iata') ?? '',
          toCity: doc.get('to_city') ?? '',
          toCountry: doc.get('to_country') ?? '');
    }).toList();
  }
}