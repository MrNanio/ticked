class CustomUser {
  String uid;
  String? email;
  String? name;
  String? surname;
  bool status;
  String role;

  CustomUser(
      {required this.uid,
        this.email,
        this.name,
        this.surname,
        required this.status,
        required this.role});

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
        uid: map['uid'],
        email: map['email'],
        name: map['name'],
        surname: map['surname'],
        status: map['status'],
        role: map['role']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'surname': surname,
      'status': status,
      'role': role
    };
  }
}