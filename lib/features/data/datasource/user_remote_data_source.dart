import 'package:capacious/features/data/models/user_model.dart';
import 'package:capacious/features/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRemoteDataSource {
  Future<Users> userDetail(String uid);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRemoteDataSourceImpl({required this.firestore});

  @override
  Future<Users> userDetail(String uid) async {
    // final memberCollectionRef = firestore.collection('member').doc(uid);
    // return memberCollectionRef;

    final snapshot = await firestore.collection('member').doc(uid).get();
    return UserModel.fromSnapshot(snapshot);
  }
}
