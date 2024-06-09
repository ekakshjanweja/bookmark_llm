import 'dart:convert';

import 'package:bookmark_llm/core/api.dart';
import 'package:bookmark_llm/core/common/local_storage/kv_store.dart';
import 'package:bookmark_llm/core/common/local_storage/kv_store_keys.dart';
import 'package:bookmark_llm/core/common/providers/firebase_providers.dart';
import 'package:bookmark_llm/core/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepoProvider = Provider<AuthRepo>(
  (ref) => AuthRepo(
    firebaseAuth: ref.read(firebaseAuthProvider),
    googleSignIn: ref.read(googleSignInProvider),
    api: Api(),
  ),
);

class AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final Api _api;

  AuthRepo(
      {required FirebaseAuth firebaseAuth,
      required GoogleSignIn googleSignIn,
      required Api api})
      : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _api = api;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    if (userCredential.additionalUserInfo!.isNewUser) {
      final user = userCredential.user;

      if (user != null) {
        UserModel userModel = UserModel(
          id: user.uid,
          name: user.displayName!,
          email: user.email!,
          seed: "Leo",
          bookmarks: [],
          collections: [],
          photoUrl: user.photoURL,
        );
        createUser(userModel);
      }
    }

    return await _firebaseAuth.signInWithCredential(credential);
  }

  void logOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  Future<UserModel?> getUserData(String email) async {
    try {
      Response response = await _api.sendRequest.get("/me", queryParameters: {
        "email": email,
      });

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        return null;
      }

      if (response.statusCode == 404) {
        return null;
      }

      KVStore.set(KvStoreKeys.user, jsonEncode(apiResponse.data["user"]));

      UserModel user = UserModel.fromMap(apiResponse.data);

      return user;
    } catch (e) {
      return null;
    }
  }

  void createUser(UserModel user) async {
    Response response = await _api.sendRequest.post("/users", data: {
      "id": user.id,
      "email": user.email,
      "name": user.name,
      "image": user.photoUrl,
      "seed": user.seed,
    });

    ApiResponse apiResponse = ApiResponse.fromResponse(response);

    if (!apiResponse.success) {
      print("Error Creating user");
      return;
    }

    print("Created User");
  }
}
