import 'package:capacious/features/domain/entities/user.dart';
import 'package:capacious/features/domain/repositories/user_repository.dart';

class GetUserDetail {
  final UserRepository repository;

  GetUserDetail({required this.repository});

  Future<Users> call(String uid) {
    return repository.getMemberDetail(uid);
  }
}
