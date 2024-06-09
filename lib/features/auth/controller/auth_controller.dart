import 'package:bookmark_llm/core/models/user_model.dart';
import 'package:bookmark_llm/features/auth/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(
    authRepo: ref.watch(authRepoProvider),
  ),
);

final authStateChangesProvider = StreamProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.authStateChanges;
  },
);

class AuthController {
  final AuthRepo _authRepo;

  AuthController({
    required AuthRepo authRepo,
  }) : _authRepo = authRepo;

  Stream<User?> get authStateChanges => _authRepo.authStateChanges;

  Future<UserCredential> signInWithGoogle() async {
    return await _authRepo.signInWithGoogle();
  }

  void logOut() {
    _authRepo.logOut();
  }

  Future<UserModel?> getUserData(String email) {
    return _authRepo.getUserData(email);
  }
}
