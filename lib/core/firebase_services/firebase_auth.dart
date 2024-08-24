import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verifeye/core/errors/base_exception.dart';
import 'package:verifeye/core/resources/data_state.dart';
import 'package:verifeye/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<DataState<UserCredential>> signInWithEmailAndPassword({
    required final String email,
    required final String password,
  }) async {
    // check if email is in lowercase or not
    if (email != email.toLowerCase()) {
      return DataFailed(
        BaseException(
          code: 'invalid_email_format',
          message: 'Email should be in lowercase characters.',
        ),
      );
    }
    // check if password and email are correct
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // check email verifie or not
      if (userCredential.user?.emailVerified == true) {
        return DataSuccess(userCredential);
      } else {
        return DataFailed(
          BaseException(
            code: 'not-verified',
            message:
                "It looks like your email address hasn't been verified yet. Please check your inbox (and spam folder, just in case) for a verification email from us. Follow the instructions in the email to complete the verification process.\nIf you didn't receive the email, you can request a new verification email.",
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // wrong password error
      return DataFailed(
        BaseException(
          code: e.code,
          message:
              'Sorry, your password or email were incorrect. Please double-check your password.',
        ),
      );
    }
  }

  Future<DataState<UserCredential>> signUpWithEmailAndPassword({
    required final String email,
    required final String password,
    required final String firstName,
    required final String lastName,
  }) async {
    if (email != email.toLowerCase()) {
      return DataFailed(
        BaseException(
          code: 'invalid_email_format',
          message: 'Email should be in lowercase characters.',
        ),
      );
    }
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user?.emailVerified == false) {
        await _auth.currentUser?.sendEmailVerification();
      }
      // keep users in user collection
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
      );
      await _db.collection('users').doc(userCredential.user!.uid).set(
            user.toMap(),
          );
      return DataSuccess(userCredential);
    } on FirebaseAuthException catch (e) {
      return DataFailed(
        BaseException(
          code: e.code,
          message: e.message,
        ),
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<DataState> sendPasswordResetEmail({
    required final String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
      return const DataSuccess(true);
    } on FirebaseAuthException catch (e) {
      return DataFailed(BaseException(code: e.code, message: e.message));
    }
  }

  Future<DataState> confirmPasswordReset({
    required final String code,
    required final String newPassword,
  }) async {
    try {
      await _auth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      return const DataSuccess(true);
    } on FirebaseAuthException catch (e) {
      return DataFailed(
        BaseException(code: e.code, message: e.message),
      );
    }
  }

  Future<DataState> reauthenticate({
    required final String password,
  }) async {
    // Email Password
    final credential = EmailAuthProvider.credential(
      email: _auth.currentUser!.email!,
      password: password,
    );

    try {
      await _auth.currentUser!.reauthenticateWithCredential(credential);
      return const DataSuccess(true);
    } on FirebaseAuthException catch (e) {
      return DataFailed(
        BaseException(code: e.code, message: e.message),
      );
    }
  }
}
