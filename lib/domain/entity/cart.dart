import 'package:isar/isar.dart';

part 'cart.g.dart';

@collection
class Cart {
  Id? id;
  final int userId;
  final int productId;
  int quantity;

  Cart({
    required this.userId,
    required this.productId,
    required this.quantity,
  });
}
