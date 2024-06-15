import 'package:bookmark_llm/core/routemaster_stuff.dart';
import 'package:bookmark_llm/features/auth/controller/auth_controller.dart';
import 'package:bookmark_llm/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main(List<String> args) async {
  // await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangesProvider).when(
          data: (data) => ShadApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Bookmarkllm',
            routerDelegate: data != null
                ? RoutemasterStuff.routemasterLoggedIn
                : RoutemasterStuff.routemasterLoggedOut,
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (error, stackTrace) => Text(
            error.toString(),
          ),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
