import 'package:capacious/features/domain/entities/subscription.dart';
import 'package:capacious/features/domain/repositories/video_repository.dart';

class SelectSubscription {
  final VideoRepository repository;

  SelectSubscription({required this.repository});

  Future<void> call(Subcription subcription) async {
    return repository.selectSubscription(subcription);
  }
}
