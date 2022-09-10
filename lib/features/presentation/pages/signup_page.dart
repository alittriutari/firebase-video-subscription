import 'package:capacious/constants/app_string.dart';
import 'package:capacious/features/domain/entities/user.dart';
import 'package:capacious/features/presentation/cubit/users_cubit.dart';
import 'package:capacious/features/presentation/pages/signin_page.dart';
import 'package:capacious/features/presentation/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign_up';
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          AppString.signUp,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Column(
              children: [
                CustomTextfield(
                  controller: nameController,
                  hintText: AppString.name,
                  title: AppString.name,
                  inputType: TextInputType.name,
                  showTitle: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  controller: emailController,
                  hintText: AppString.email,
                  title: AppString.email,
                  inputType: TextInputType.emailAddress,
                  showTitle: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfield(
                  controller: passwordController,
                  inputType: TextInputType.visiblePassword,
                  hintText: AppString.password,
                  title: AppString.password,
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
                        if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && nameController.text.isNotEmpty) {
                          try {
                            BlocProvider.of<UsersCubit>(context)
                                .signUp(Users(email: emailController.text, password: passwordController.text, name: nameController.text, subsType: 0))
                                .whenComplete(() {
                              Navigator.pushNamedAndRemoveUntil(context, SignInPage.routeName, (route) => false);
                            });
                          } catch (e) {
                            final snackbar = SnackBar(content: Text(e.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                        }
                      },
                      child: const Text(AppString.signUp)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
