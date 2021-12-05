import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticked/models/custom_user.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/models/route.dart';

class RouteService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference routesCollection =
    FirebaseFirestore.instance.collection('routes');
  final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');
  final CollectionReference flightsCollection =
  FirebaseFirestore.instance.collection('flights');

  Future addRoute(String fromIata, String toIata) async {
    var documentSnapshot = await userCollection
        .where('email', isEqualTo: _auth.currentUser!.email)
        .get();
    var map = (documentSnapshot.docs[0].data() as Map<String, dynamic>);

    var customUser = CustomUser.fromMap(map);


    await routesCollection.add({
      "fromIata": fromIata,
      "toIata": toIata,
      "airlineCode": customUser.airlineCode
    });
  }

  Stream<List<Flight>> getFlights() {
    return flightsCollection.snapshots().map(_flightsListFromSnapshot);
  }

  List<Flight> _flightsListFromSnapshot(QuerySnapshot snapshot) {
    var flights = snapshot.docs
        .map((doc) => Flight.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return flights;
  }

  Stream<List<Route>> getRoutes(String airlinesCode) {
    return routesCollection
        .where('airlinesCode', isEqualTo: airlinesCode)
        .snapshots()
        .map(_routesListFromSnapshot);
  }

  List<Route> _routesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Route(
          toIata: doc.get('toIata'),
          fromIata: doc.get('formIata'),
          airlineCode: doc.get('airlineCode'));
    }).toList();
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
        airlineCode: doc.get('airline_Code') ?? '',
        fromIata: doc.get('from_iata') ?? '',
        toIata: doc.get('to_iata') ?? '',
      );
    }).toList();
  }
}