import 'package:auto_route/auto_route.dart';
import 'package:bookmark_llm/core/common/providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(double.infinity),
              child: Image.network(
                ref.watch(firebaseAuthProvider).currentUser!.photoURL!,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              ref.watch(firebaseAuthProvider).currentUser!.displayName!,
            ),
          ],
        ),
      ),
    );
  }
}
