import 'package:capacious/features/domain/entities/user.dart';
import 'package:capacious/features/domain/repositories/user_repository.dart';

import '../datasource/user_remote_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});
  @override
  Future<Users> getMemberDetail(String uid) async => dataSource.userDetail(uid);
}
