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

  Future addTickets(String flightCode, int ticketClassA,
      int ticketClassB, int ticketClassC) async {
    //give user and airlinie data
    var documentSnapshot = await userCollection
        .where('email', isEqualTo: _auth.currentUser!.email)
        .get();
    var map = (documentSnapshot.docs[0].data() as Map<String, dynamic>);
    var customUser = CustomUser.fromMap(map);

    //give flight
    var flightFromDb = await flightsCollection
        .where('flight_code', isEqualTo: flightCode)
        .get();
    var mapFlight = (flightFromDb.docs[0].data() as Map<String, dynamic>);
    var flight = Flight.fromMap(mapFlight);

    //zarezerwowany, niezarezerwowany, niezaakceptowany
    //sprawdzenie warunków ładowności
    var ticketsClassAFromDb = await ticketsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'A')
        .get();
    var ticketsClassBFromDb = await ticketsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'B')
        .get();
    var ticketsClassCFromDb = await ticketsCollection
        .where('flight_code', isEqualTo: flightCode)
        .where('class_of_ticket', isEqualTo: 'C')
        .get();

    // var sumFromDB = ticketsClassAFromDb.size +
    //     ticketsClassBFromDb.size +
    //     ticketsClassCFromDb.size;


    if (ticketsClassAFromDb.size + ticketClassA > int.parse(flight.capacityClassA)) {
        //wyjątek przekroczona ładowność klasa A
    }

    if (ticketsClassBFromDb.size + ticketClassB > int.parse(flight.capacityClassB)) {
      //wyjątek przekroczona ładowność klasa B
    }

    if (ticketsClassCFromDb.size + ticketClassC > int.parse(flight.capacityClassC)) {
      //wyjątek przekroczona ładowność klasa C
    }

    /*int sum = ticketClassA + ticketClassB + ticketClassC;
    if (sum > int.parse(flight.capacity) - sumFromDB) {
      //wyjątek przekroczona ładowność
    }*/

    //give uid
    var uuid = const Uuid();

    for (var i = 1; i <= ticketClassA; i++) {
      await ticketsCollection.add({
        'route_code': flight.routeCode,
        'airline_code': flight.airlineCode,
        'from_iata': flight.fromIata,
        'from_city': flight.fromCity,
        'from_country': flight.fromCountry,
        'to_iata': flight.toIata,
        'to_city': flight.toCity,
        'to_country': flight.toCountry,
        'date': flight.date,
        'time': flight.time,
        'class_of_ticket': "A",
        'flight_id': flightCode,
        'seat_number': 'CLA' + (i + ticketsClassAFromDb.size).toString(),
        'ticket_code': uuid.v4(),
        'ticket_status': 'niezarezerwowany',
        'user_id': 'null'
      });
    }

    for (var i = 1; i <= ticketClassB; i++) {
      await ticketsCollection.add({
        'route_code': flight.routeCode,
        'airline_code': flight.airlineCode,
        'from_iata': flight.fromIata,
        'from_city': flight.fromCity,
        'from_country': flight.fromCountry,
        'to_iata': flight.toIata,
        'to_city': flight.toCity,
        'to_country': flight.toCountry,
        'date': flight.date,
        'time': flight.time,
        'class_of_ticket': "B",
        'flight_id': flightCode,
        'seat_number': 'CLB' + (i + ticketsClassBFromDb.size).toString(),
        'ticket_code': uuid.v4(),
        'ticket_status': 'niezarezerwowany',
        'user_id': 'null'
      });
    }

    for (var i = 1; i <= ticketClassC; i++) {
      await ticketsCollection.add({
        'route_code': flight.routeCode,
        'airline_code': flight.airlineCode,
        'from_iata': flight.fromIata,
        'from_city': flight.fromCity,
        'from_country': flight.fromCountry,
        'to_iata': flight.toIata,
        'to_city': flight.toCity,
        'to_country': flight.toCountry,
        'date': flight.date,
        'time': flight.time,
        'class_of_ticket': "C",
        'flight_id': flightCode,
        'seat_number': 'CLC' + (i + ticketsClassCFromDb.size).toString(),
        'ticket_code': uuid.v4(),
        'ticket_status': 'niezarezerwowany',
        'user_id': 'null'
      });
    }
  }

  //akceptacja przez admina
  Future acceptTicket(String ticketCode) async {
    QuerySnapshot querySnapshot = await ticketsCollection
        .where('ticket_code', isEqualTo: ticketCode)
        .get();
    QueryDocumentSnapshot doc = querySnapshot.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef
        .update({'ticket_status': 'zarezerwowany'})
        .then((_) => print('Updated- accept ticket'))
        .catchError((error) => print('Update failed: $error'));
  }

  //rezerwacja przez usera
  Future bookTicket(String flightCode, String ticketClass) async {
    var documentSnapshot = await userCollection
        .where('email', isEqualTo: _auth.currentUser!.email)
        .get();
    var map = (documentSnapshot.docs[0].data() as Map<String, dynamic>);
    var customUser = CustomUser.fromMap(map);

    QuerySnapshot querySnapshot = await ticketsCollection
        .where('class_of_ticket', isEqualTo: ticketClass)
        .where('user_id', isEqualTo: 'null')
        .where('flight_id', isEqualTo: flightCode)
        .get();
    if (querySnapshot.size == 0) {
      //wywal wyjątek brak miejsca tego
    }
    print(querySnapshot.size);
    QueryDocumentSnapshot doc = querySnapshot.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef
        .update(
            {'ticket_status': 'niezaakceptowany', 'user_id': customUser.uid})
        .then((_) => print('Updated - book ticket'))
        .catchError((error) => print('Update failed: $error'));
  }

  //anulowanie rezerwacja przez usera
  Future deleteTicketReservation(String ticketCode) async {
    QuerySnapshot querySnapshot = await ticketsCollection
        .where('ticket_code', isEqualTo: ticketCode)
        .get();
    QueryDocumentSnapshot doc = querySnapshot.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef
        .update({'ticket_status': 'niezarezerwowany', 'user_id': 'null'})
        .then((_) => print('Updated - delete book ticket'))
        .catchError((error) => print('Update failed: $error'));
  }

  //get user tickets
  Stream<List<Ticket>> getUserTickets(){
    return ticketsCollection
        .where('user_id', isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .map(_ticketsListFromSnapshot);
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
