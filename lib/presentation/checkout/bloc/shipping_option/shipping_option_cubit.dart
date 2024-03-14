import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/presentation/checkout/bloc/shipping_option/shipping_option_state.dart';

class ShippingOptionCubit extends Cubit<ShippingOptionState> {
  ShippingOptionCubit() : super(
    ShippingOptionState(
      options: [
        {'name': "JNE", 'isChecked': true},
        {'name': "JNT", 'isChecked': false},
        {'name': "AnterAja", 'isChecked': false},
      ],
    ),
  );

  void toggleOption(int index, bool? isChecked) {
    final options = state.options.map((e) => e..['isChecked'] = false).toList();
    emit(
      state.copyWith(
          options: options..[index]['isChecked'] = isChecked
      ),
    );
  }
}