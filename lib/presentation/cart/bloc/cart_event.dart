sealed class CartEvent {}

final class GetCartItems extends CartEvent {
  final int userId;

  GetCartItems(this.userId);
}

final class AddItem extends CartEvent {
  final int userId;
  final int productId;

  AddItem(this.userId, this.productId);
}

final class RemoveItem extends CartEvent {
  final int userId;
  final int productId;

  RemoveItem(this.userId, this.productId);
}