class Route {
  final String routeId;
  final String airlineCode;
  final String fromIata;
  final String toIata;

  Route(
      {
        required this.routeId,
        required this.airlineCode,
        required this.fromIata,
        required this.toIata
      });
}