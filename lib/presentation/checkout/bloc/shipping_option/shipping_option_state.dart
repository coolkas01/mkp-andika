class ShippingOptionState {
  List<Map> options;

  ShippingOptionState({
    required this.options,
  });

  ShippingOptionState copyWith({final List<Map>? options}) =>
      ShippingOptionState(
        options: options ?? this.options,
      );
}