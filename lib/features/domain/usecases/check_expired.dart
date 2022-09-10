import 'package:capacious/features/domain/repositories/video_repository.dart';

class CheckExpired {
  final VideoRepository repository;

  CheckExpired({required this.repository});

  Future<void> call(String uid) async {
    return repository.checkExpired(uid);
  }
}
