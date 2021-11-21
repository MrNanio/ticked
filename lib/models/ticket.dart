class Ticket {
  final String classOfTicket;
  final String flightId;
  final int seatNumber;
  final String ticketCode;
  final String ticketStatus;
  final String userId;

  Ticket(
      {
        required this.classOfTicket,
        required this.flightId,
        required this.seatNumber,
        required this.ticketCode,
        required this.ticketStatus,
        required this.userId
      });
}