part of 'video_cubit.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoEmpty extends VideoState {}

class VideoLoaded extends VideoState {
  final List<Video> video;
  const VideoLoaded({required this.video});

  @override
  List<Object> get props => [video];
}

class VideoSuccess extends VideoState {}

class VideoFailure extends VideoState {}

class SubsStatus extends VideoState {
  final bool subStatus;
  const SubsStatus({required this.subStatus});

  @override
  List<Object> get props => [subStatus];
}
