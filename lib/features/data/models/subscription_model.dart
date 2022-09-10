import 'package:capacious/features/domain/entities/subscription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubcriptionModel extends Subcription {
  const SubcriptionModel({required super.uid, required super.price, required super.subsId, required super.subsType, required super.createdAt});

  factory SubcriptionModel.fromSnapshot(DocumentSnapshot documentSnapshot) => SubcriptionModel(
      uid: documentSnapshot.get('uid'),
      price: documentSnapshot.get('price'),
      subsId: documentSnapshot.get('subs_id'),
      subsType: documentSnapshot.get('subs_type'),
      createdAt: documentSnapshot.get('created_at'));

  Map<String, dynamic> toDocument() {
    return {'uid': uid, 'price': price, 'subs_id': subsId, 'subs_type': subsType, 'created_at': createdAt};
  }
}
