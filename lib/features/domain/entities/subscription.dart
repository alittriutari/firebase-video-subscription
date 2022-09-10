import 'package:equatable/equatable.dart';

class Subcription extends Equatable {
  final String? uid;
  final String? price;
  final String? subsId;
  final int? subsType;
  final DateTime? createdAt;

  const Subcription({required this.uid, required this.price, this.subsId, required this.subsType, required this.createdAt});

  @override
  List<Object?> get props => [uid, price, subsId, subsType, createdAt];
}
