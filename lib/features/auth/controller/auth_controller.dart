import 'package:bookmark_llm/features/auth/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
}
