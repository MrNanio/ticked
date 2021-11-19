import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticked/models/flight.dart';

class FlightService {

  final CollectionReference flightsCollection = FirebaseFirestore.instance.collection('flights');

  Future updateFlightData(Flight f) async {
    return await flightsCollection.doc(f.flightUid).set({
        'capacity': f.capacity,
        'date': f.date,
        'time': f.time,
        'flight_code': f.flightCode,
        'route_uid': f.routeId
    });
  }

  List<Flight> _flightListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Flight(
          flightUid: doc.id,
          capacity: doc.get('capacity'),
          date: doc.get('date'),
          time: doc.get('time'),
          flightCode: doc.get('flight_code'),
          routeId: doc.get('route_uid')
      );
    }).toList();
  }

  Stream<List<Flight>> get flights {
    return flightsCollection.snapshots()
        .map(_flightListFromSnapshot);
  }
}