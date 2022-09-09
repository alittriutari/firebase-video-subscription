import 'package:capacious/features/domain/entities/user.dart';
import 'package:capacious/features/domain/repositories/auth_repository.dart';

class DoSignIn {
  final AuthRepository repository;

  DoSignIn({required this.repository});

  Future<void> call(Users user) async {
    return await repository.signIn(user);
  }
}
