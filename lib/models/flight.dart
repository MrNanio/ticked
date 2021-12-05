class Flight {
  final String capacity;
  final String date;
  final String time;
  final String flightCode;
  final String fromIata;
  final String toIata;

  Flight(
      {required this.capacity,
      required this.date,
      required this.time,
      required this.flightCode,
      required this.fromIata,
      required this.toIata});

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      capacity: map['capacity'],
      date: map['date'],
      flightCode: map['flight_code'],
      fromIata: map['from_iata'],
      toIata: map['to_iata'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'capacity': capacity,
      'date': date,
      'flight_code': flightCode,
      'from_iata': fromIata,
      'to_iata': toIata,
      'time': time
    };
  }
}
