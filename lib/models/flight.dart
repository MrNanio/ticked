class Flight {
  final int capacity;
  final String date;
  final String time;
  final String flightCode;
  final String fromIata;
  final String toIata;

  Flight({
    required this.capacity,
    required this.date,
    required this.time,
    required this.flightCode,
    required this.fromIata,
    required this.toIata
  });
}