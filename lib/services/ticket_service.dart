import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ticked/models/custom_user.dart';
import 'package:ticked/models/flight.dart';
import 'package:ticked/models/route.dart';
import 'package:ticked/models/ticket.dart';
import 'package:uuid/uuid.dart';

class TicketService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference airportCollection =
      FirebaseFirestore.instance.collection('airports');
  final CollectionReference routesCollection =
      FirebaseFirestore.instance.collection('routes');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference flightsCollection =
      FirebaseFirestore.instance.collection('flights');
  final CollectionReference ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');

  Future addTicket(
      String routeCode, String flightCode, String ticketClass) async {
    //give user and airlinie data
    var documentSnapshot = await userCollection
        .where('email', isEqualTo: _auth.currentUser!.email)
        .get();
    var map = (documentSnapshot.docs[0].data() as Map<String, dynamic>);
    var customUser = CustomUser.fromMap(map);

    //give route
    var routeFromDb =
        await routesCollection.where('route_code', isEqualTo: routeCode).get();
    var mapRoute = (routeFromDb.docs[0].data() as Map<String, dynamic>);
    var route = Route.fromMap(mapRoute);
    //give flight
    var flightFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .get();
    var mapFlight = (flightFromDb.docs[0].data() as Map<String, dynamic>);
    var flight = Flight.fromMap(mapFlight);

    //zarezerwowany, niezarezerwowany, niezaakceptowany
    //sprawdzenie warunków ładowności
    var ticketsClassAFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'A')
        .get();
    var ticketsClassBFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'B')
        .get();
    var ticketsClassCFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'C')
        .get();

    var sumFromDB = ticketsClassAFromDb.size +
        ticketsClassBFromDb.size +
        ticketsClassCFromDb.size;

    if (int.parse(flight.capacity) < sumFromDB + 1) {
      //wyjątek przekroczona ładowność
    }

    var seatNumber = '0';
    if (ticketClass == 'A') {
      var numTic = ticketsClassAFromDb.size + 1;
      seatNumber = 'CLA' + numTic.toString();
    }
    if (ticketClass == 'B') {
      var numTic = ticketsClassBFromDb.size + 1;
      seatNumber = 'CLB' + numTic.toString();
    }
    if (ticketClass == 'C') {
      var numTic = ticketsClassCFromDb.size + 1;
      seatNumber = 'CLC' + numTic.toString();
    }

    //give uid
    var uuid = const Uuid();

    await ticketsCollection.add({
      'route_code': routeCode,
      'airline_code': flight.airlineCode,
      'from_iata': flight.fromIata,
      'from_city': flight.fromCity,
      'from_country': flight.fromCountry,
      'to_iata': flight.toIata,
      'to_city': flight.toCity,
      'to_country': flight.toCountry,
      'class_of_ticket': ticketClass,
      'flight_id': flightCode,
      'seat_number': seatNumber,
      'ticket_code': uuid.v4(),
      'ticket_status': 'niezarezerwowany',
      'user_id': 'null'
    });
  }

  Future addTickets(String routeCode, String flightCode, int ticketClassA,
      int ticketClassB, int ticketClassC) async {
    //give user and airlinie data
    var documentSnapshot = await userCollection
        .where('email', isEqualTo: _auth.currentUser!.email)
        .get();
    var map = (documentSnapshot.docs[0].data() as Map<String, dynamic>);
    var customUser = CustomUser.fromMap(map);

    //give route
    var routeFromDb =
        await routesCollection.where('route_code', isEqualTo: routeCode).get();
    var mapRoute = (routeFromDb.docs[0].data() as Map<String, dynamic>);
    var route = Route.fromMap(mapRoute);

    //give flight
    var flightFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .get();
    var mapFlight = (flightFromDb.docs[0].data() as Map<String, dynamic>);
    var flight = Flight.fromMap(mapFlight);

    //zarezerwowany, niezarezerwowany, niezaakceptowany
    //sprawdzenie warunków ładowności
    var ticketsClassAFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'A')
        .get();
    var ticketsClassBFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'B')
        .get();
    var ticketsClassCFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'C')
        .get();

    var sumFromDB = ticketsClassAFromDb.size +
        ticketsClassBFromDb.size +
        ticketsClassCFromDb.size;

    int sum = ticketClassA + ticketClassB + ticketClassC;
    if (sum > int.parse(flight.capacity) - sumFromDB) {
      //wyjątek przekroczona ładowność
    }

    //give uid
    var uuid = const Uuid();

    for (var i = 1; i >= ticketClassA; i++) {
      await ticketsCollection.add({
        'route_code': routeCode,
        'airline_code': flight.airlineCode,
        'from_iata': flight.fromIata,
        'from_city': flight.fromCity,
        'from_country': flight.fromCountry,
        'to_iata': flight.toIata,
        'to_city': flight.toCity,
        'to_country': flight.toCountry,
        'class_of_ticket': "A",
        'flight_id': flightCode,
        'seat_number': 'CLA' + (i + ticketsClassAFromDb.size).toString(),
        'ticket_code': uuid.v4(),
        'ticket_status': 'niezarezerwowany',
        'user_id': 'null'
      });
    }

    for (var i = 0; i > ticketClassB; i++) {
      await ticketsCollection.add({
        'route_code': routeCode,
        'airline_code': flight.airlineCode,
        'from_iata': flight.fromIata,
        'from_city': flight.fromCity,
        'from_country': flight.fromCountry,
        'to_iata': flight.toIata,
        'to_city': flight.toCity,
        'to_country': flight.toCountry,
        'class_of_ticket': "B",
        'flight_id': flightCode,
        'seat_number': 'CLB' + (i + ticketsClassBFromDb.size).toString(),
        'ticket_code': uuid.v4(),
        'ticket_status': 'niezarezerwowany',
        'user_id': 'null'
      });
    }

    for (var i = 0; i > ticketClassC; i++) {
      await ticketsCollection.add({
        'route_code': routeCode,
        'airline_code': flight.airlineCode,
        'from_iata': flight.fromIata,
        'from_city': flight.fromCity,
        'from_country': flight.fromCountry,
        'to_iata': flight.toIata,
        'to_city': flight.toCity,
        'to_country': flight.toCountry,
        'class_of_ticket': "C",
        'flight_id': flightCode,
        'seat_number': 'CLC' + (i + ticketsClassCFromDb.size).toString(),
        'ticket_code': uuid.v4(),
        'ticket_status': 'niezarezerwowany',
        'user_id': 'null'
      });
    }
  }

  Stream<List<Ticket>> getTickets(String flightId) {
    return ticketsCollection
        .where('flight_id', isEqualTo: flightId)
        .snapshots()
        .map(_ticketsListFromSnapshot);
  }

  Stream<List<Ticket>> getTicketsByClass(String flightId, String ticketClass) {
    return ticketsCollection
        .where('flight_id', isEqualTo: flightId)
        .where('class_of_ticket', isEqualTo: ticketClass)
        .snapshots()
        .map(_ticketsListFromSnapshot);
  }

  List<Ticket> _ticketsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Ticket.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
