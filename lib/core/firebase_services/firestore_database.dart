import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verifeye/models/image_info_model.dart';
import 'package:verifeye/models/searched_link_model.dart';
import 'package:verifeye/models/user_model.dart';

class FirestoreDatabaseService {
  final User currentUser = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  // set link to db
  Future<void> setLink(SearchedLink link) async {
    // get current user uid
    String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    await _db.collection('links').doc(currentUserUid).set(
          link.toMap(),
        );
  }

  Stream<SearchedLink?> getLink(String url) {
    SearchedLink? link;
    // get current user map
    final result = FirebaseFirestore.instance
        .collection('links')
        .where('url', isEqualTo: url);

    return result.snapshots().map(
      (snapshot) {
        for (final doc in snapshot.docs) {
          final Map<String, dynamic> dataMap = doc.data();
          link = SearchedLink.fromMap(dataMap);
        }
        return link;
      },
    );
  }

  Stream<ImageInfo?> getImageInfo(String userUid) {
    final DocumentReference<Map<String, dynamic>> result =
        FirebaseFirestore.instance.collection('photoTime').doc(userUid);

    return result.snapshots().map(
      (snapshot) {
        if (!snapshot.exists) {
          return null;
        }
        final Map<String, dynamic> dataMap = snapshot.data()!;
        return ImageInfo.fromMap(dataMap);
      },
    );
  }

  // delete image info from photo time collection
  Future<void> deletePhotoInfo(String userUId) async {
    await FirebaseFirestore.instance
        .collection('photoTime')
        .doc(userUId)
        .delete();
  }
}
