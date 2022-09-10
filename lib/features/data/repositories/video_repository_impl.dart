import 'package:capacious/features/data/datasource/video_remote_data_source.dart';
import 'package:capacious/features/domain/entities/subscription.dart';
import 'package:capacious/features/domain/entities/video.dart';
import 'package:capacious/features/domain/repositories/video_repository.dart';

class VideoRepositoryImpl extends VideoRepository {
  final VideoRemoteDataSource dataSource;

  VideoRepositoryImpl({required this.dataSource});
  @override
  Stream<List<Video>> getVideo() => dataSource.getVideo();

  @override
  Future<void> deleteSubscription(Subcription subcription) async => dataSource.deleteSubscription(subcription);

  @override
  Future<void> selectSubscription(Subcription subcription) async => dataSource.selectSubscription(subcription);

  @override
  Future<bool> checkSubsStatus(String uid) async => dataSource.checkSubscription(uid);

  @override
  Future<void> checkExpired(String uid) async => dataSource.checkExpired(uid);
}
