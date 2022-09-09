part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UserLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final Users? users;
  const UsersLoaded({this.users});

  @override
  List<Object> get props => [users!];
}

class UserFailure extends UsersState {}

class UsersData extends UsersState {
  final Users users;

  const UsersData({required this.users});

  @override
  List<Object> get props => [users];
}
