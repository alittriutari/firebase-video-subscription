import 'package:capacious/features/domain/repositories/video_repository.dart';

class CheckSubsStatus {
  final VideoRepository repository;

  CheckSubsStatus({required this.repository});

  Future<bool> call(String uid) async {
    return repository.checkSubsStatus(uid);
  }
}
