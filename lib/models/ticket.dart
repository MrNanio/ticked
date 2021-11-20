class Ticket {
  final String classOfTicket;
  final String flightUid;
  final int seatNumber;
  final String ticketCode;
  final String ticketStatus;
  final String userUid;

  Ticket(
      {
        required this.classOfTicket,
        required this.flightUid,
        required this.seatNumber,
        required this.ticketCode,
        required this.ticketStatus,
        required this.userUid
      });
}