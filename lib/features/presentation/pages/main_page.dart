import 'package:capacious/constants/app_string.dart';
import 'package:capacious/features/presentation/pages/signin_page.dart';
import 'package:capacious/features/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static const routeName = '/main_page';
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              const AspectRatio(
                aspectRatio: 1,
                child: Center(
                  child: Text(
                    AppString.intro,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, SignUpPage.routeName);
                      },
                      child: const Text(AppString.createAccount)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppString.alreadyHaveAccount),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignInPage.routeName);
                      },
                      child: const Text(AppString.signIn)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
