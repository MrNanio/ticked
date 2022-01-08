class Ticket {
  final String routeCode;
  final String airlineCode;
  final String fromIata;
  final String fromCity;
  final String toIata;
  final String toCity;
  final String classOfTicket;
  final String flightId;
  final int seatNumber;
  final String ticketCode;
  final String ticketStatus;
  final String userId;

  Ticket(
      {required this.toCity,
      required this.routeCode,
      required this.airlineCode,
      required this.fromIata,
      required this.fromCity,
      required this.toIata,
      required this.classOfTicket,
      required this.flightId,
      required this.seatNumber,
      required this.ticketCode,
      required this.ticketStatus,
      required this.userId});
}
