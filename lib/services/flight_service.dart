import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticked/models/airline.dart';
import 'package:ticked/models/custom_user.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/models/route.dart';
import 'package:uuid/uuid.dart';

class FlightService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference airportCollection =
      FirebaseFirestore.instance.collection('airports');
  final CollectionReference routesCollection =
      FirebaseFirestore.instance.collection('routes');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference flightsCollection =
      FirebaseFirestore.instance.collection('flights');
  final CollectionReference airlinesCollection =
  FirebaseFirestore.instance.collection('airlines');

  Future addFlight(
      String routeCode, String date, String time, String capacityClassA, String capacityClassB, String capacityClassC) async {
    //give user and airlinie data
    var documentSnapshot = await userCollection
        .where('email', isEqualTo: _auth.currentUser!.email)
        .get();
    var map = (documentSnapshot.docs[0].data() as Map<String, dynamic>);
    var customUser = CustomUser.fromMap(map);

    //give airline
    var airlineFromDb =
    await airlinesCollection.where('code', isEqualTo: customUser.airlineCode).get();
    var mapAirline = (airlineFromDb.docs[0].data() as Map<String, dynamic>);
    var airline = Airline.fromMap(mapAirline);

    //give route
    var routeFromDb =
        await routesCollection.where('route_code', isEqualTo: routeCode).get();
    var mapRoute = (routeFromDb.docs[0].data() as Map<String, dynamic>);
    var route = Route.fromMap(mapRoute);

    //give uid
    var uuid = const Uuid();

    await flightsCollection.add({
      'capacity_class_A': capacityClassA,
      'capacity_class_B': capacityClassB,
      'capacity_class_C': capacityClassC,
      'date': date,
      'time': time,
      'flight_code': uuid.v4(),
      'route_code': routeCode,
      'from_iata': route.fromIata,
      'from_city': route.fromCity,
      'from_country': route.fromCountry,
      'to_iata': route.toIata,
      'to_city': route.toCity,
      'to_country': route.toCountry,
      'airline_code': customUser.airlineCode,
      'airline_name': airline.name
    });
  }

  Stream<List<Flight>> getFlights(String routeId) {
    return flightsCollection
        .where('route_uid', isEqualTo: routeId)
        .snapshots()
        .map(_flightsListFromSnapshot);
  }

  Future<DocumentSnapshot<Object?>> getFlight(String flightCode) async {

    QuerySnapshot querySnapshot = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .get();
    QueryDocumentSnapshot doc = querySnapshot.docs[0];
    DocumentReference docRef = doc.reference;
    return docRef.snapshots().first;
  }

  Stream<List<Flight>> getAllFlights() {
    return flightsCollection.snapshots().map(_flightsListFromSnapshot);
  }

  Stream<List<Flight>> getFlightListByIataCodesAndDate(
      String fromIata, String toIata, String date) {
    return flightsCollection
        .where('from_iata', isEqualTo: fromIata)
        .where('to_iata', isEqualTo: toIata)
        .where('date', isEqualTo: date)
        .snapshots()
        .map(_flightsListFromSnapshot);
  }

  List<Flight> _flightsListFromSnapshot(QuerySnapshot snapshot) {
    var flights = snapshot.docs
        .map((doc) => Flight.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return flights;
  }
}