import 'package:capacious/features/domain/entities/subscription.dart';
import 'package:capacious/features/domain/entities/video.dart';

abstract class VideoRepository {
  Stream<List<Video>> getVideo();
  Future<void> selectSubscription(Subcription subcription);
  Future<void> deleteSubscription(Subcription subcription);
  Future<bool> checkSubsStatus(String uid);
  Future<void> checkExpired(String uid);
}
