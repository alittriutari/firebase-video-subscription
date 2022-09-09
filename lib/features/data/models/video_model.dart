import 'package:capacious/features/domain/entities/video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel extends Video {
  const VideoModel(
      {final int? id,
      final String? author,
      final String? title,
      final String? url,
      final String? thumbnail})
      : super(
            author: author,
            title: title,
            id: id,
            url: url,
            thumbnail: thumbnail);

  factory VideoModel.fromSnapshot(DocumentSnapshot documentSnapshot) =>
      VideoModel(
          id: documentSnapshot.get('id'),
          author: documentSnapshot.get('author'),
          title: documentSnapshot.get('title'),
          thumbnail: documentSnapshot.get('thumbnail'),
          url: documentSnapshot.get('url'));

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'author': author,
      'title': title,
      'url': url,
      'thumbnail': thumbnail
    };
  }
}
