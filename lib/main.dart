import 'package:capacious/features/presentation/cubit/auth_cubit.dart';
import 'package:capacious/features/presentation/cubit/users_cubit.dart';
import 'package:capacious/features/presentation/cubit/video_cubit.dart';
import 'package:capacious/features/presentation/pages/home_page.dart';
import 'package:capacious/features/presentation/pages/main_page.dart';
import 'package:capacious/firebase_options.dart';
import 'package:capacious/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersCubit>(
          create: (_) => locator<UsersCubit>(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => locator<AuthCubit>()..appStarted(),
        ),
        BlocProvider<VideoCubit>(
          create: (_) => locator<VideoCubit>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Capacious',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xffD32F2F),
          ),
        ),
        initialRoute: '/',
        onGenerateRoute: Routes().route,
        routes: {
          '/': (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              }
              if (authState is UnAuthenticated) {
                return const MainPage();
              }
              return const Center(child: CircularProgressIndicator());
            });
          }
        },
      ),
    );
  }
}
