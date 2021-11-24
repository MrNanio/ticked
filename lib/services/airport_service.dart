import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticked/models/airport.dart';

class AirportService {

    final CollectionReference airportsCollection = FirebaseFirestore.instance.collection('airports');

    Stream<List<Airport>> get airports {
        return airportsCollection.orderBy('city').snapshots()
            .map(_airportListFromSnapshot);
    }

    List<Airport> _airportListFromSnapshot(QuerySnapshot snapshot){
        return snapshot.docs.map((doc) {
            return Airport(
                city: doc.get('city')  ?? '',
                country: doc.get('country')  ?? '',
                iataCode: doc.get('iata_code')  ?? '',
                name: doc.get('name') ?? '',
            );
        }).toList();
    }
}