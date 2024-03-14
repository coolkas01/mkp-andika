import 'package:mitra/domain/entity/user.dart';

class UserDto extends User {
  UserDto({
    required super.id,
    required super.username,
    required super.name,
    super.email,
    super.phone,
    super.address,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      UserDto(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        name: FullName(
          firstName: json['name']['firstname'],
          lastName: json['name']['lastname'],
        ),
        address: UAddress(
          city: json['address']['city'],
          street: json['address']['street'],
          number: json['address']['number'],
          zipCode: json['address']['zipcode'],
          latLng: ALatLng(
            lat: json['address']['geolocation']['lat'],
            lng: json['address']['geolocation']['long'],
          ),
        ),
      );
}