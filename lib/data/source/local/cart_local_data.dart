import 'package:isar/isar.dart';
import 'package:mitra/domain/entity/cart.dart';

abstract class CartLocalData {
  Future<List<Cart>> getCartItems({required int userId});
  addItemToCart({
    required int userId,
    required int productId,
    required int quantity,
  });
}

class CartLocalDataImpl implements CartLocalData {
  // late final Future<Isar> _isar;

  // CartLocalDataImpl() :
  //       _isar = _load();

  // static Future<Isar> _load() async {
  //   if (Isar.instanceNames.isEmpty) {
  //     final dir = await getApplicationDocumentsDirectory();
  //     return Isar.open([CartSchema], directory: dir.path);
  //   }
  //   return Future.value(Isar.getInstance());
  // }

  @override
  Future<List<Cart>> getCartItems({required int userId}) async {
    final isar = Isar.getInstance();
    if (isar == null) {
      return [];
    }
    return isar.carts.filter()
        .userIdEqualTo(userId)
        .findAll();
  }

  @override
  Future<void> addItemToCart({
    required int userId,
    required int productId,
    required int quantity}) async {
    final isar = Isar.getInstance();
    if (isar == null) {
      return;
    }

    final item = Cart(
      userId: userId,
      productId: productId,
      quantity: quantity,
    );
    final temp = await isar.carts.filter()
      .userIdEqualTo(userId)
      .productIdEqualTo(productId)
      .findFirst();

    if (temp != null) {
      item.id = temp.id;
      item.quantity = item.quantity + temp.quantity;
    }

    isar.writeTxn(() => isar.carts.put(item));
  }
}