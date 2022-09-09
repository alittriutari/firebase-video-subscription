import 'package:capacious/features/domain/entities/user.dart';
import 'package:capacious/features/presentation/cubit/auth_cubit.dart';
import 'package:capacious/features/presentation/cubit/users_cubit.dart';
import 'package:capacious/features/presentation/pages/home_page.dart';
import 'package:capacious/features/presentation/widget/custom_text_field.dart';
import 'package:capacious/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: locator<GlobalKey<ScaffoldState>>(),
      backgroundColor: Colors.white,
      body: BlocConsumer<UsersCubit, UsersState>(
        builder: (context, userState) {
          if (userState is UsersLoaded) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              } else {
                return _signInForm();
              }
            });
          }
          return _signInForm();
        },
        listener: (context, userState) {
          if (userState is UsersLoaded) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
        },
      ),
    );
  }

  Widget _signInForm() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Form(
              key: locator<GlobalKey<FormState>>(),
              child: Column(
                children: [
                  CustomTextfield(
                    controller: emailController,
                    hintText: 'Email',
                    title: 'Email',
                    inputType: TextInputType.emailAddress,
                    showTitle: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    controller: passwordController,
                    inputType: TextInputType.visiblePassword,
                    hintText: 'Password',
                    title: 'Password',
                    obsecureText: true,
                    showTitle: true,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (locator<GlobalKey<FormState>>()
                              .currentState!
                              .validate()) {
                            try {
                              BlocProvider.of<UsersCubit>(context)
                                  .signIn(Users(
                                      email: emailController.text,
                                      password: passwordController.text))
                                  .whenComplete(() {});
                            } catch (e) {
                              final snackbar =
                                  SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            }
                          }

                          FocusScope.of(context).unfocus();
                        },
                        child: const Text('Sign in')),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
