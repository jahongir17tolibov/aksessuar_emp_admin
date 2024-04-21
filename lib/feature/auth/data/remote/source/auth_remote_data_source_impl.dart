import 'package:aksessuar_emp_admin/feature/auth/data/remote/dto/user_dto.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/source/auth_remote_data_source.dart';
import 'package:aksessuar_emp_admin/feature/auth/data/remote/util/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<AuthResult<UserDto>> createUserByEmail(String email, String password) async {
    try {
      return await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((it) async {
        User? user = it.user;
        final UserDto userDto = UserDto(
          userUId: user?.uid,
          userName: user?.displayName,
          email: user?.email,
          userProfileUrl: user?.photoURL,
        );
        return AuthResult(data: userDto);
      });
    } on FirebaseAuthException catch (e, st) {
      debugPrintStack(stackTrace: st);
      return AuthResult(errorMessage: e.toString());
    }
  }

  @override
  Future<AuthResult<UserDto>> signInUserByEmail(String email, String password) async {
    try {
      return await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((it) {
        User? user = it.user;
        final UserDto userDto = UserDto(
          userUId: user?.uid,
          userName: user?.displayName,
          email: user?.email,
          userProfileUrl: user?.photoURL,
        );
        return AuthResult(data: userDto);
      });
    } on FirebaseAuthException catch (e, st) {
      debugPrintStack(stackTrace: st);
      return AuthResult(errorMessage: e.toString());
    }
  }

  @override
  Future<AuthResult<UserDto>> signInByGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential).then((userCredential) {
        User? googleUser = userCredential.user;
        final UserDto userDto = UserDto(
          userUId: googleUser?.uid,
          userName: googleUser?.displayName,
          email: googleUser?.email,
          userProfileUrl: googleUser?.photoURL,
        );
        return AuthResult(data: userDto);
      });
    } on FirebaseAuthException catch (e, st) {
      debugPrintStack(stackTrace: st);
      return AuthResult(errorMessage: e.toString());
    }
  }

  @override
  Future<UserDto?> getSignedUser() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      return UserDto(
        userUId: user?.uid,
        userName: user?.displayName,
        email: user?.email,
        userProfileUrl: user?.photoURL,
      );
    } on FirebaseAuthException catch (e, st) {
      debugPrintStack(stackTrace: st);
      throw Exception(e);
    }
  }
}
