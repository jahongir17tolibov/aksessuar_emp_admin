import 'package:aksessuar_emp_admin/feature/home/data/remote/dto/users_order_dto.dart';
import 'package:aksessuar_emp_admin/feature/home/data/remote/source/home_remote_data_source.dart';
import 'package:aksessuar_emp_admin/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  })  : _firestore = firestore,
        _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  @override
  Stream<List<UsersOrderDto>> getUsersOrderData() async* {
    try {
      yield* _firestore.collection(FirebaseConstants.testDataCollection).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => UsersOrderDto.fromMap(doc.data())).toList());
    } on FirebaseException catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw (e.toString());
    }
  }

  @override
  Future<void> addRandomTestData(UsersOrderDto usersOrderDto) async {
    try {
      final ordersCollection = _firestore.collection(FirebaseConstants.testDataCollection);
      await ordersCollection.add(usersOrderDto.toMap()).then((docRef) async {
        final orderDocId = docRef.id;
        await docRef.update({'user_uid': orderDocId});
      });
    } on FirebaseException catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTestData(String id) async {
    try {
      await _firestore.collection(FirebaseConstants.testDataCollection).doc(id).delete();
    } on FirebaseException catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception(e);
    }
  }
}
