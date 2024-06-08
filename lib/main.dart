import 'package:bookmark_llm/features/auth/controller/auth_controller.dart';
import 'package:bookmark_llm/firebase_options.dart';
import 'package:bookmark_llm/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main(List<String> args) async {
  // await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangesProvider).when(
          data: (data) => ShadApp.router(
            debugShowCheckedModeBanner: false,
            title: 'GovBuzz',
            routerConfig: _appRouter.config(
              reevaluateListenable: ref.read(authStateChangesProvider),
            ),
          ),
          error: (error, stackTrace) => Text(
            error.toString(),
          ),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
