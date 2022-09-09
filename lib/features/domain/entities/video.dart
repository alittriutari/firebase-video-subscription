import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final int? id;
  final String? author;
  final String? title;
  final String? thumbnail;
  final String? url;

  const Video({this.id, this.author, this.title, this.thumbnail, this.url});

  @override
  List<Object?> get props => [id, author, title, thumbnail, url];
}
