import 'package:bloc/bloc.dart';
import 'package:capacious/features/domain/entities/user.dart';
import 'package:capacious/features/domain/usecases/do_sign_in.dart';
import 'package:capacious/features/domain/usecases/do_sign_up.dart';
import 'package:capacious/features/domain/usecases/get_user_detail.dart';
import 'package:equatable/equatable.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final DoSignUp doSignUp;
  final DoSignIn doSignIn;
  final GetUserDetail getUserDetail;
  UsersCubit({
    required this.doSignUp,
    required this.doSignIn,
    required this.getUserDetail,
  }) : super(UsersInitial());

  Future<void> signUp(Users users) async {
    emit(UserLoading());
    try {
      await doSignUp(users);
      emit(const UsersLoaded());
    } catch (e) {
      emit(UserFailure());
    }
  }

  Future<void> signIn(Users users) async {
    emit(UserLoading());
    try {
      await doSignIn(users);

      emit(const UsersLoaded());
    } catch (e) {
      emit(UserFailure());
    }
  }

  Future<void> fetchUserDetail(String uid) async {
    emit(UserLoading());
    try {
      await getUserDetail(uid).then((value) {
        // emit(UsersData(users: value));
        emit(UsersLoaded(users: value));
      });
    } catch (e) {
      emit(UserFailure());
    }
  }
}
