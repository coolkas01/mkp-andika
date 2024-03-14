class User {
  final int id;
  final String username;
  final FullName name;
  final String? email;
  final String? phone;
  final UAddress? address;

  User({
    required this.id,
    required this.username,
    required this.name,
    this.email,
    this.phone,
    this.address,
  });
}

class FullName {
  final String firstName;
  final String lastName;

  FullName({
    required this.firstName,
    required this.lastName,
  });
}

class UAddress {
  final String city;
  final String street;
  final int number;
  final String zipCode;
  final ALatLng latLng;

  UAddress({
    required this.city,
    required this.street,
    required this.zipCode,
    required this.latLng,
    this.number = 0,
  });
}

class ALatLng {
  final String lat;
  final String lng;

  ALatLng({
    required this.lat,
    required this.lng,
  });
}