import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/presentation/checkout/bloc/payment_option/payment_option_cubit.dart';
import 'package:mitra/presentation/checkout/bloc/payment_option/payment_option_state.dart';

import '../../domain/entity/product.dart';
import 'bloc/shipping_option/shipping_option_cubit.dart';
import 'bloc/shipping_option/shipping_option_state.dart';

class CheckoutItemPage extends StatelessWidget {
  const CheckoutItemPage({super.key, required this.product, required this.quantity});

  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              PaymentOptionCubit(),
        ),
        BlocProvider(
          create: (_) =>
              ShippingOptionCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Image.network(product.image ?? ''),
                title: Text(product.title, softWrap: false),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Qty: $quantity'),
                    Text('Price: ${product.price}'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text('Shipping address', style: Theme.of(context).textTheme.titleMedium),
              const Text('Jl. Tenggilis Permai B-24, Tenggilis Mejoyo, Surabaya'),
              const SizedBox(height: 16.0),
              Text('Payment options', style: Theme.of(context).textTheme.titleMedium),
              const PaymentOptionView(),
              Text('Shipping options', style: Theme.of(context).textTheme.titleMedium),
              const ShippingOptionView(),
              Text('Total: ${product.price * quantity}', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(flex: 2),
              Center(
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('Buy'),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentOptionView extends StatelessWidget {
  const PaymentOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentOptionCubit, PaymentOptionState>(
      builder: (_, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.options.length,
          itemBuilder: (_, index) =>
              CheckboxListTile(
                title: Text(state.options[index]['name']),
                value: state.options[index]['isChecked'],
                onChanged: (isChecked) =>
                    context.read<PaymentOptionCubit>().toggleOption(index, isChecked),
              ),
        );
      },
    );
  }
}

class ShippingOptionView extends StatelessWidget {
  const ShippingOptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShippingOptionCubit, ShippingOptionState>(
      builder: (_, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.options.length,
          itemBuilder: (_, index) =>
              CheckboxListTile(
                title: Text(state.options[index]['name']),
                value: state.options[index]['isChecked'],
                onChanged: (isChecked) =>
                    context.read<ShippingOptionCubit>().toggleOption(index, isChecked),
              ),
        );
      },
    );
  }
}

