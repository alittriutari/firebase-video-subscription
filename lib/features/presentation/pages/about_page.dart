import 'package:capacious/constants/app_string.dart';
import 'package:capacious/features/presentation/cubit/auth_cubit.dart';
import 'package:capacious/features/presentation/cubit/users_cubit.dart';
import 'package:capacious/features/presentation/pages/main_page.dart';
import 'package:capacious/features/presentation/widget/simple_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutPage extends StatefulWidget {
  final String uid;
  const AboutPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UsersCubit>(context).fetchUserDetail(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.profile),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Card(
          elevation: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
                if (state is UsersLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          state.users!.name!,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          state.users!.email!,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.amberAccent,
                          child: state.users!.subsType == 0
                              ? const Text(AppString.youDontHaveSubscription)
                              : Text('Your subscription type is ${state.users!.subsType == 1 ? "Basic" : "Pro"}'),
                        )
                      ],
                    ),
                  );
                }
                return const SizedBox();
              }),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleAlertDialog(
                            title: AppString.logout,
                            body: AppString.logoutConfirm,
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context).logout();
                              Navigator.of(context).pushNamedAndRemoveUntil(MainPage.routeName, (route) => false);
                            },
                          );
                        });
                  },
                  child: const Text(
                    AppString.logout,
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
