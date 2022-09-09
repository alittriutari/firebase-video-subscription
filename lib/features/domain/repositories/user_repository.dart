import 'package:capacious/features/domain/entities/user.dart';

abstract class UserRepository {
  Future<Users> getMemberDetail(String uid);
}
