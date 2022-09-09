import 'package:capacious/features/domain/entities/subscription.dart';
import 'package:capacious/features/domain/repositories/video_repository.dart';

class DeleteSubscription {
  final VideoRepository repository;

  DeleteSubscription({required this.repository});

  Future<void> call(Subcription subcription) async {
    return repository.deleteSubscription(subcription);
  }
}
