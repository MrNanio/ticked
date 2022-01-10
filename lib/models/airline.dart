class Airline {
  final String name;
  final String code;

  Airline({
    required this.name,
    required this.code,
  });

  factory Airline.fromMap(Map<String, dynamic> map) {
    return Airline(name: map['name'], code: map['code']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'code': code};
  }
}
