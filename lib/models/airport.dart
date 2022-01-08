class Airport {
  final String city;
  final String country;
  final String iataCode;
  final String name;

  Airport(
      {required this.city,
      required this.country,
      required this.iataCode,
      required this.name});

  factory Airport.fromMap(Map<String, dynamic> map) {
    return Airport(
        city: map['city'],
        country: map['country'],
        iataCode: map['iata_code'],
        name: map['name']);
  }

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'country': country,
      'iata_code': iataCode,
      'name': name
    };
  }
}