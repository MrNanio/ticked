import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticked/models/flight.dart';

class FlightService {

  final CollectionReference flightsCollection = FirebaseFirestore.instance.collection('flights');


  Stream<List<Flight>> getFlightListByIataCodesAndDate(String fromIata, String toIata, String date) {
    return flightsCollection
        .where('from_iata', isEqualTo: fromIata)
        .where('to_iata', isEqualTo: toIata)
        .where('date', isEqualTo: date)
        .snapshots()
        .map(_flightsListFromSnapshot);
  }

  /*List<Flight> _flightListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Flight(
          capacity: doc.get('capacity') ?? 0,
          date: doc.get('date') ?? '',
          time: doc.get('time') ?? '',
          flightCode: doc.get('flight_code') ?? '',
          fromIata: doc.get('from_iata') ?? '',
          toIata: doc.get('to_iata') ?? ''
      );
    }).toList();
  }*/

  List<Flight> _flightsListFromSnapshot(QuerySnapshot snapshot) {
    var flights = snapshot.docs
        .map((doc) => Flight.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
    return flights;
  }
}