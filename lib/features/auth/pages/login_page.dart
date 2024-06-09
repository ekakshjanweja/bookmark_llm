import 'package:bookmark_llm/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class LoginPage extends ConsumerWidget {
  static const routeName = "/";

  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            ref.read(authControllerProvider).signInWithGoogle().whenComplete(
                  () => Routemaster.of(context).push(LoginPage.routeName),
                );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
