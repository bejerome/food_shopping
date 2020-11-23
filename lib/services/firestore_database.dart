import 'dart:async';
import 'dart:io';

import 'package:camping_fanatics/models/user_model.dart';
import 'package:camping_fanatics/services/firestore_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:camping_fanatics/services/firestore_path.dart';
import 'package:camping_fanatics/services/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in Firestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todos item to have the complete status
changed to true.

 */
class FirestoreDatabase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;
  final CloudStorageService _firestoreStorage = new CloudStorageService();
  //Method to create/update todoModel

  //Method to retrieve user info item from the same user based on uid
  Stream<List<UserModel>> userDetailsStream() =>
      _firestoreService.collectionStream(
        path: FirestoreUserPath.userDetails(uid),
        builder: (data, documentId) => UserModel.fromMap(data, documentId),
      );

  //Method to mark all todoModel to be complete
  Future<void> setAllTodoComplete() async {
    final batchUpdate = Firestore.instance.batch();

    final querySnapshot = await Firestore.instance
        .collection(FirestorePath.todos(uid))
        .getDocuments();

    for (DocumentSnapshot ds in querySnapshot.documents) {
      batchUpdate.updateData(ds.reference, {'complete': true});
    }
    await batchUpdate.commit();
  }

  Future<void> deleteAllTodoWithComplete() async {
    final batchDelete = Firestore.instance.batch();

    final querySnapshot = await Firestore.instance
        .collection(FirestorePath.todos(uid))
        .where('complete', isEqualTo: true)
        .getDocuments();

    for (DocumentSnapshot ds in querySnapshot.documents) {
      batchDelete.delete(ds.reference);
    }
    await batchDelete.commit();
  }

  Future<CloudStorageResult> uploadImage(File imageFile, fileName) async {
    return await _firestoreStorage.uploadImage(
        imageToUpload: imageFile, title: fileName);
  }

  Future<void> setUserDetails(UserModel user) async =>
      await _firestoreService.setData(
        path: FirestoreUserPath.addUserInfo(uid, documentIdFromCurrentDate()),
        data: user.toMap(),
      );
}
