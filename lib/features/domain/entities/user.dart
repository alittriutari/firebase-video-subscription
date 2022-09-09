import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String? uid;
  final String? email;
  final String? password;
  final String? name;
  final int? subsType;

  const Users(
      {required this.email, this.uid, this.password, this.name, this.subsType});

  @override
  List<Object?> get props => [email, uid, password, name, subsType];
}
