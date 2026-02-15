class User {
  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;
  final Address address;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstName: json['name']['firstname'],
      lastName: json['name']['lastname'],
      phone: json['phone'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
    );
  }
  
  @override
  String toString() => '$number $street, $city, $zipcode';
}
