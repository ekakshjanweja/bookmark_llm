import 'dart:convert';

import 'package:bookmark_llm/core/common/local_storage/kv_store.dart';
import 'package:bookmark_llm/core/common/local_storage/kv_store_keys.dart';
import 'package:bookmark_llm/core/common/providers/firebase_providers.dart';
import 'package:bookmark_llm/core/models/user_model.dart';
import 'package:bookmark_llm/features/auth/controller/auth_controller.dart';
import 'package:bookmark_llm/features/home/notifs/local_notifs.dart';
import 'package:bookmark_llm/features/home/notifs/notifs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeName = "/";
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  UserModel? userModel;

  void getData(String email) async {
    userModel = await ref.read(authControllerProvider).getUserData(email);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    KVStore.init();
    Notifs.init();
    scheduledNotis();
  }

  void scheduledNotis() async {
    await LocalNotifs.showScheduleNotif(
      id: ScheduleNotifications.test1.id,
      scheduledDate: DateTime.utc(2024, 6, 15, 4, 54, 00),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () {
                ref.read(authControllerProvider).logOut();
              },
              child: const Text("Logout"),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () {
                final User? user = ref.read(firebaseAuthProvider).currentUser;
                if (user != null) {
                  getData(user.email!);

                  print(jsonDecode(KVStore.get<String>(KvStoreKeys.user)!));
                }
              },
              child: const Text("Get User Data"),
            ),
          ],
        ),
      ),
    );
  }
}
