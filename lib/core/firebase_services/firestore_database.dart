import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verifeye/models/user_model.dart';

class FirestoreDatabaseService {
  final User currentUser = FirebaseAuth.instance.currentUser!;

  Stream<AppUser?> getCurrentUser() {
    AppUser? user;
    // get current user uid
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    // get current user map
    final result = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentUserUid);

    return result.snapshots().map(
      (snapshot) {
        for (final doc in snapshot.docs) {
          final Map<String, dynamic> dataMap = doc.data();
          user = AppUser.fromMap(dataMap);
        }
        return user;
      },
    );
  }
  // get current user
  // Stream<AppUser?> getCurrentUser() {
  //   final DocumentReference<Map<String, dynamic>> docRef =
  //       FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
  //       print('object');
  //   print(currentUser!.displayName);

  //   return docRef.snapshots().map(
  //     (event) {
  //       if (event.data() == null) {
  //         return null;
  //       }
  //       final Map<String, dynamic> dataMap = event.data()!;
  //       return AppUser.fromMap(dataMap);
  //     },
  //   );
  // }

  // change user info
  Future<void> updateUserInfo(AppUser user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
          user.toMap(),
        );
  }

  // delete user from users collection
  Future<void> deleteUser(String userUId) async {
    await FirebaseFirestore.instance.collection('users').doc(userUId).delete();
  }
}
