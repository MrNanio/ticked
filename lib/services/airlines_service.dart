import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticked/models/airline.dart';

class FlightService {
  final CollectionReference airlinesCollection =
      FirebaseFirestore.instance.collection('airlines');

  Stream<List<Airline>> getAirline(String airlinesCode) {
    return airlinesCollection
        .where('code', isEqualTo: airlinesCode)
        .snapshots()
        .map(_airlineListFromSnapshot);
  }

  List<Airline> _airlineListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Airline(name: doc.get("name"), code: doc.get("code"));
    }).toList();
  }
}