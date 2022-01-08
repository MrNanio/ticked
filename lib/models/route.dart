class Route {
  final String routeCode;
  final String airlineCode;
  final String fromIata;
  final String fromCity;
  final String fromCountry;
  final String toIata;
  final String toCity;
  final String toCountry;

  Route(
      {required this.routeCode,
      required this.airlineCode,
      required this.fromIata,
      required this.fromCity,
      required this.fromCountry,
      required this.toIata,
      required this.toCity,
      required this.toCountry});

  factory Route.fromMap(Map<String, dynamic> map) {
    return Route(
        routeCode: map['route_code'],
        airlineCode: map['airline_code'],
        fromIata: map['from_iata'],
        fromCity: map['from_city'],
        fromCountry: map['from_country'],
        toIata: map['to_iata'],
        toCity: map['to_city'],
        toCountry: map['to_country']);
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
      'to_country': toCountry
    };
  }
}
