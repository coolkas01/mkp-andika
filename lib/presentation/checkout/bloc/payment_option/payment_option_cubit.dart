import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/presentation/checkout/bloc/payment_option/payment_option_state.dart';

class PaymentOptionCubit extends Cubit<PaymentOptionState> {
  PaymentOptionCubit() : super(
    PaymentOptionState(
      options: [
        {'name': "BCA", 'isChecked': true},
        {'name': "BNI", 'isChecked': false},
        {'name': "Mandiri", 'isChecked': false},
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