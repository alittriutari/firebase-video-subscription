import 'package:capacious/features/data/datasource/auth_remote_data_source.dart';
import 'package:capacious/features/data/datasource/user_remote_data_source.dart';
import 'package:capacious/features/data/datasource/video_remote_data_source.dart';
import 'package:capacious/features/data/repositories/auth_repository_impl.dart';
import 'package:capacious/features/data/repositories/user_repository_impl.dart';
import 'package:capacious/features/data/repositories/video_repository_impl.dart';
import 'package:capacious/features/domain/repositories/auth_repository.dart';
import 'package:capacious/features/domain/repositories/user_repository.dart';
import 'package:capacious/features/domain/repositories/video_repository.dart';
import 'package:capacious/features/domain/usecases/check_expired.dart';
import 'package:capacious/features/domain/usecases/check_subs_status.dart';
import 'package:capacious/features/domain/usecases/delete_subscription.dart';
import 'package:capacious/features/domain/usecases/do_logout.dart';
import 'package:capacious/features/domain/usecases/do_sign_in.dart';
import 'package:capacious/features/domain/usecases/do_sign_up.dart';
import 'package:capacious/features/domain/usecases/get_current_uid.dart';
import 'package:capacious/features/domain/usecases/get_user_detail.dart';
import 'package:capacious/features/domain/usecases/get_video.dart';
import 'package:capacious/features/domain/usecases/is_sign_in.dart';
import 'package:capacious/features/domain/usecases/select_subscription.dart';
import 'package:capacious/features/presentation/cubit/auth_cubit.dart';
import 'package:capacious/features/presentation/cubit/users_cubit.dart';
import 'package:capacious/features/presentation/cubit/video_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  //cubit
  locator.registerFactory<UsersCubit>(() => UsersCubit(doSignUp: locator(), doSignIn: locator(), getUserDetail: locator()));
  locator.registerFactory<AuthCubit>(() => AuthCubit(isSignIn: locator(), getCurrentUid: locator(), doLogout: locator()));
  locator.registerFactory<VideoCubit>(() => VideoCubit(
      getVideo: locator(), deleteSubscription: locator(), selectSubscription: locator(), checkSubsStatus: locator(), checkExpired: locator()));

  //usecases
  locator.registerLazySingleton<DoSignUp>(() => DoSignUp(repository: locator()));
  locator.registerLazySingleton<DoSignIn>(() => DoSignIn(repository: locator()));
  locator.registerLazySingleton<IsSignIn>(() => IsSignIn(repository: locator()));
  locator.registerLazySingleton<GetCurrentUid>(() => GetCurrentUid(repository: locator()));
  locator.registerLazySingleton<GetVideo>(() => GetVideo(repository: locator()));
  locator.registerLazySingleton<DoLogout>(() => DoLogout(repository: locator()));
  locator.registerLazySingleton<GetUserDetail>(() => GetUserDetail(repository: locator()));
  locator.registerLazySingleton<SelectSubscription>(() => SelectSubscription(repository: locator()));
  locator.registerLazySingleton<DeleteSubscription>(() => DeleteSubscription(repository: locator()));
  locator.registerLazySingleton<CheckSubsStatus>(() => CheckSubsStatus(repository: locator()));
  locator.registerLazySingleton<CheckExpired>(() => CheckExpired(repository: locator()));

  //repository
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dataSource: locator()));
  locator.registerLazySingleton<VideoRepository>(() => VideoRepositoryImpl(dataSource: locator()));
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(dataSource: locator()));

  //data source
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(firebaseAuth: locator()));
  locator.registerLazySingleton<VideoRemoteDataSource>(() => VideoRemoteDataSourceImpl(firestore: locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(firestore: locator()));

  //external
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => fireStore);
  locator.registerLazySingleton<GlobalKey<ScaffoldState>>(() => GlobalKey<ScaffoldState>());
  locator.registerLazySingleton<GlobalKey<FormState>>(() => GlobalKey<FormState>());
}
