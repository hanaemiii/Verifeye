import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final Reference storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadImage(
    File file,
    String imageName,
  ) async {
    // Reference to the location in firebase to upload image
    Reference reference = storageRef.child(imageName);

    // Upload the file to firebase
    await reference.putFile(file);

    // Wait till the file is uploaded then store the download url
    final String url = await reference.getDownloadURL();
    return url;
  }

  Future<bool> deleteUploadedFile(String fileName) async {
    // Reference to the location in firebase to delete file
    Reference reference = storageRef.child(fileName);

    // delete the file
    await reference.delete();
    return true;
  }

  Future<void> deleteImageFolder(String folderPath) async {
    final storageRef = FirebaseStorage.instance.ref();
    final ListResult result = await storageRef.child(folderPath).listAll();

    for (var fileRef in result.items) {
      await fileRef.delete();
    }
  }
}
