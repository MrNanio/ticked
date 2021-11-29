import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticked/models/flight.dart';

class FlightService {

  final CollectionReference flightsCollection = FirebaseFirestore.instance.collection('flights');

  /*Future updateFlightData(Flight f) async {
    return await flightsCollection.doc(f.flightUid).set({
        'capacity': f.capacity,
        'date': f.date,
        'time': f.time,
        'flight_code': f.flightCode,
        'route_uid': f.routeId
    });
  }*/

  Stream<List<Flight>> getFlights(String routeId) {
    return flightsCollection
        .where('route_uid', isEqualTo: routeId)
        .snapshots()
        .map(_flightListFromSnapshot);
  }

  Stream<List<Flight>> getFlightListByIataCodesAndDate(String fromIata, String toIata, String date) {
    return flightsCollection
        .where('from_iata', isEqualTo: fromIata)
        .where('to_iata', isEqualTo: toIata)
        .where('date', isEqualTo: date)
        .snapshots()
        .map(_flightListFromSnapshot);
  }

  List<Flight> _flightListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Flight(
          capacity: doc.get('capacity'),
          date: doc.get('date'),
          time: doc.get('time'),
          flightCode: doc.get('flight_code'),
          fromIata: doc.get('from_iata'),
          toIata: doc.get('to_iata')
      );
    }).toList();
  }
}