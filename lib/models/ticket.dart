class Ticket {
  //from route or flight
  final String routeCode;
  final String airlineCode;
  final String fromIata;
  final String fromCity;
  final String fromCountry;
  final String toIata;
  final String toCity;
  final String toCountry;
  final String date;
  final String time;
  //ticket
  final String classOfTicket;
  //sprawdzaj z pulą podczas dodawania
  final String flightId;
  final int seatNumber;
  final String ticketCode;
  final String ticketStatus;
  final String userId;

  Ticket({
    required this.routeCode,
    required this.airlineCode,
    required this.fromIata,
    required this.fromCity,
    required this.fromCountry,
    required this.toIata,
    required this.toCity,
    required this.toCountry,
    required this.date,
    required this.time,
    required this.classOfTicket,
    required this.flightId,
    required this.seatNumber,
      required this.ticketCode,
      required this.ticketStatus,
      required this.userId});

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
        routeCode: map['route_code'],
        airlineCode: map['airline_code'],
        fromIata: map['from_iata'],
        fromCity: map['from_city'],
        fromCountry: map['from_country'],
        toIata: map['to_iata'],
        toCity: map['to_city'],
        toCountry: map['to_country'],
        date: map['date'],
        time: map['time'],
        classOfTicket: map['class_of_ticket'],
        flightId: map['flight_id'],
        seatNumber: map['seatNumber'],
        ticketCode: map['ticketCode'],
        ticketStatus: map['ticketStatus'],
        userId: map['userId']);
  }

  Map<String, dynamic> toMap() {
    return {
      'route_code': routeCode,
      'airline_code': airlineCode,
      'from_iata': fromIata,
      'from_city': fromCity,
      'from_country': fromCountry,
      'to_iata': toIata,
      'to_city': toCity,
      'to_country': toCountry,
      'date': date,
      'time': time,
      'class_of_ticket': classOfTicket,
      'flight_id': flightId,
      'seat_number': seatNumber,
      'ticket_code': ticketCode,
      'ticket_status': ticketStatus,
      'user_id': userId
    };
  }
}
