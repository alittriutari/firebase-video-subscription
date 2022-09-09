import 'package:capacious/features/domain/entities/video.dart';
import 'package:capacious/features/domain/repositories/video_repository.dart';

class GetVideo {
  final VideoRepository repository;

  GetVideo({required this.repository});

  Stream<List<Video>> call() {
    return repository.getVideo();
  }
}
