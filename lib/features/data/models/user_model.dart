import 'package:capacious/features/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends Users {
  const UserModel(
      {required String? email,
      required String? uid,
      String? password,
      String? name,
      int? subsType})
      : super(
            email: email,
            uid: uid,
            password: password,
            name: name,
            subsType: subsType);

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
        uid: documentSnapshot.get('uid'),
        email: documentSnapshot.get('email'),
        name: documentSnapshot.get('name'),
        subsType: documentSnapshot.get('subs_type'));
  }

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'email': email,
      'password': password,
      'name': name,
      'subs_type': subsType
    };
  }
}
