class PaymentOptionState {
  List<Map> options;
  
  PaymentOptionState({
    required this.options,
  });
  
  PaymentOptionState copyWith({final List<Map>? options}) =>
      PaymentOptionState(
        options: options ?? this.options,
      );
}