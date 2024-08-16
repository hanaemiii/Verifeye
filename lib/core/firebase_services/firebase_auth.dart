import 'package:firebase_auth/firebase_auth.dart';
import 'package:verifeye/core/errors/base_exception.dart';
import 'package:verifeye/core/resources/data_state.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DataState<UserCredential>> signInWithEmailAndPassword({
    required final String email,
    required final String password,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return DataSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      return DataFailed(
        BaseException(
          e.message,
        ),
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
