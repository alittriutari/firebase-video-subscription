import 'package:capacious/features/domain/entities/user.dart';
import 'package:capacious/features/domain/repositories/auth_repository.dart';

class DoSignUp {
  final AuthRepository repository;

  DoSignUp({required this.repository});

  Future<void> call(Users user) async {
    return await repository.signUp(user);
  }
}
