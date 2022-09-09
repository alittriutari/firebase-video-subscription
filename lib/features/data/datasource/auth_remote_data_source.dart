import 'package:capacious/features/data/models/user_model.dart';
import 'package:capacious/features/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<void> signIn(Users users);
  Future<void> signUp(Users users);
  Future<void> logout();
  Future<bool> isSignIn();
  Future<String> getCurrentUId();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});
  @override
  Future<void> signIn(Users users) async =>
      firebaseAuth.signInWithEmailAndPassword(
          email: users.email!, password: users.password!);

  @override
  Future<void> signUp(Users users) async {
    var result = await firebaseAuth.createUserWithEmailAndPassword(
        email: users.email!, password: users.password!);
    User user = result.user!;
    final newUser = UserModel(
            email: user.email, uid: user.uid, name: users.name, subsType: 0)
        .toDocument();

    await FirebaseFirestore.instance
        .collection('member')
        .doc(user.uid)
        .set(newUser);
  }

  @override
  Future<void> logout() async => firebaseAuth.signOut();

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<String> getCurrentUId() async => firebaseAuth.currentUser!.uid;
}
