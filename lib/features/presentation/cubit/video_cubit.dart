import 'package:bloc/bloc.dart';
import 'package:capacious/features/domain/entities/subscription.dart';
import 'package:capacious/features/domain/entities/video.dart';
import 'package:capacious/features/domain/usecases/check_subs_status.dart';
import 'package:capacious/features/domain/usecases/delete_subscription.dart';
import 'package:capacious/features/domain/usecases/get_video.dart';
import 'package:capacious/features/domain/usecases/select_subscription.dart';
import 'package:capacious/helper.dart';
import 'package:equatable/equatable.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final GetVideo getVideo;
  final SelectSubscription selectSubscription;
  final DeleteSubscription deleteSubscription;
  final CheckSubsStatus checkSubsStatus;

  VideoCubit(
      {required this.getVideo,
      required this.selectSubscription,
      required this.deleteSubscription,
      required this.checkSubsStatus})
      : super(VideoInitial());

  Future<void> fetchVideo() async {
    emit(VideoLoading());
    try {
      getVideo().listen((event) {
        if (event.isEmpty) {
          emit(VideoEmpty());
        } else {
          emit(VideoLoaded(video: event));
        }
      });
    } catch (e) {
      emit(VideoFailure());
    }
  }

  Future<void> selectSubs(Subcription subcription) async {
    try {
      await selectSubscription(subcription);
    } catch (e) {
      showShortToast(e.toString());
    }
  }

  Future<void> resetSubs(Subcription subcription) async {
    emit(VideoLoading());
    try {
      await deleteSubscription(subcription);
    } catch (e) {
      showShortToast(e.toString());
    }
  }

  Future<bool> checkSubscriptionStatus(String uid) async {
    try {
      final isSubscribed = await checkSubsStatus(uid);

      return isSubscribed;
    } catch (e) {
      return false;
    }
  }
}
