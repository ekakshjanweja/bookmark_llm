import 'package:auto_route/auto_route.dart';
import 'package:bookmark_llm/features/auth/controller/auth_controller.dart';
import 'package:bookmark_llm/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            ref.read(authControllerProvider).signInWithGoogle().whenComplete(
                  () => context.router.push(
                    const HomeRoute(),
                  ),
                );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
