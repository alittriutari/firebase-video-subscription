import 'package:capacious/features/data/models/subscription_model.dart';
import 'package:capacious/features/data/models/video_model.dart';
import 'package:capacious/features/domain/entities/subscription.dart';
import 'package:capacious/features/domain/entities/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class VideoRemoteDataSource {
  Stream<List<Video>> getVideo();
  Future<void> selectSubscription(Subcription subcription);
  Future<void> deleteSubscription(Subcription subcription);
  Future<bool> checkSubscription(String uid);
  Future<void> checkExpired(String uid);
}

class VideoRemoteDataSourceImpl extends VideoRemoteDataSource {
  final FirebaseFirestore firestore;

  VideoRemoteDataSourceImpl({required this.firestore});

  @override
  Stream<List<Video>> getVideo() {
    final videoCollectionRef = firestore.collection('video');
    return videoCollectionRef.snapshots().map((query) => query.docs.map((e) => VideoModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> selectSubscription(Subcription subcription) async {
    final subsCollectionRef = firestore.collection('users').doc(subcription.uid).collection('transaction');
    final subsId = subsCollectionRef.doc().id;
    subsCollectionRef.doc(subsId).get().then((value) {
      final newSubs =
          SubcriptionModel(uid: subcription.uid, price: subcription.price, subsId: subsId, subsType: subcription.subsType, createdAt: DateTime.now())
              .toDocument();
      subsCollectionRef.doc(subsId).set(newSubs);
    });

    Map<String, dynamic> userMap = {};
    final userCollectionRef = firestore.collection('member');
    userMap['subs_type'] = subcription.subsType;
    userCollectionRef.doc(subcription.uid).update(userMap);
  }

  @override
  Future<void> deleteSubscription(Subcription subcription) async {
    final subsCollectionRef = firestore.collection('users').doc(subcription.uid).collection('transaction');
    subsCollectionRef.doc(subcription.subsId).get().then((value) {
      if (value.exists) {
        subsCollectionRef.doc(subcription.subsId).delete();
      }
      return;
    });
  }

  @override
  Future<bool> checkSubscription(String uid) async {
    QuerySnapshot snap = await firestore.collection('member').where('uid', isEqualTo: uid).get();

    if (snap.docs.isNotEmpty) {
      DocumentSnapshot doc = snap.docs.first;
      if (doc['subs_type'] == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  Future<void> checkExpired(String uid) async {
    QuerySnapshot transactionSnap = await firestore.collection('users').doc(uid).collection('transaction').where('uid', isEqualTo: uid).get();

    Map<String, dynamic> userMap = {};
    final userCollectionRef = firestore.collection('member');
    userMap['subs_type'] = 0;

    if (transactionSnap.docs.isNotEmpty) {
      DocumentSnapshot doc = transactionSnap.docs.first;
      final dateThreeMonth = doc['created_at'].toDate().add(const Duration(days: 90));
      final dateOneMonth = doc['created_at'].toDate().add(const Duration(days: 30));

      if (doc['subs_type'] == 1) {
        if (dateOneMonth.isBefore(DateTime.now())) {
          userCollectionRef.doc(uid).update(userMap);
        }
      } else if (doc['subs_type'] == 2) {
        if (dateThreeMonth.isBefore(DateTime.now())) {
          userCollectionRef.doc(uid).update(userMap);
        }
      }
    }
  }
}
