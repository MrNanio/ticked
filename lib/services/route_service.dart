import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticked/models/route.dart';


class RouteService {
  final CollectionReference routesCollection = FirebaseFirestore.instance.collection('routes');

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
        airlineCode: doc.get('airline_Code')  ?? '',
        fromIata: doc.get('from_iata') ?? '',
        toIata: doc.get('to_iata') ?? '',
      );
    }).toList();
  }
}