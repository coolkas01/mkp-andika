import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitra/domain/repository/auth_repository.dart';
import 'package:mitra/presentation/auth/bloc/auth_event.dart';

import 'bloc/auth_bloc.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              FilledButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LoginSubmitted(username: _usernameController.text, password: _passwordController.text));
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (_) =>
                  //         const ProductListPage(),
                  //   ),
                  // );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
