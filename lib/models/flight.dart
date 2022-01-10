class Flight {
  final String capacityClassA;
  final String capacityClassB;
  final String capacityClassC;
  final String date;
  final String time;
  final String flightCode;
  final String routeCode;
  final String fromIata;
  final String toIata;
  final String fromCity;
  final String toCity;
  final String fromCountry;
  final String toCountry;
  final String airlineCode;
  final String airlineName;

  Flight(
      {required this.capacityClassA,
        required this.capacityClassB,
        required this.capacityClassC,
        required this.date,
        required this.time,
        required this.flightCode,
        required this.routeCode,
        required this.fromIata,
        required this.toIata,
        required this.fromCity,
        required this.toCity,
        required this.fromCountry,
        required this.toCountry,
        required this.airlineCode,
        required this.airlineName});

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(

        capacityClassA: map['capacity_class_A'],
        capacityClassB: map['capacity_class_B'],
        capacityClassC: map['capacity_class_C'],
        date: map['date'],
        flightCode: map['flight_code'],
        routeCode: map['route_code'],
        fromIata: map['from_iata'],
        toIata: map['to_iata'],
        time: map['time'],
        fromCity: map['from_city'],
        toCity: map['to_city'],
        fromCountry: map['from_country'],
        toCountry: map['to_country'],
        airlineCode: map['airline_code'],
        airlineName: map['airline_name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'capacity_class_A': capacityClassA,
      'capacity_class_B': capacityClassB,
      'capacity_class_C': capacityClassC,
      'date': date,
      'flight_code': flightCode,
      'route_code': routeCode,
      'from_iata': fromIata,
      'to_iata': toIata,
      'time': time,
      'from_city': fromCity,
      'to_city': toCity,
      'from_country': fromCountry,
      'to_country': toCountry,
      'airline_code': airlineCode,
      'airline_name': airlineName
    };
  }
}
