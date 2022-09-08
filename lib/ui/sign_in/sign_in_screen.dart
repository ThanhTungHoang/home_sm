import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_sm/blocs/auth_bloc/auth_bloc.dart';
import 'package:home_sm/core/constants.dart';
import 'package:home_sm/core/router/routes.dart';
import 'package:home_sm/models/login/login_model.dart';
import 'components/already_have_an_account_acheck.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }
// if (await FirebaseAuth.instance.currentUser() != null) {
//     // signed in
// } else {

// }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (FirebaseAuth.instance.currentUser != null) {
        log("da dang nhap");

        // setState(() {
        GoRouter.of(context).goNamed(RouteNames.dashBoard);
        // });
      } else {
        log("chua dang nhap");
      }
    });
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              GoRouter.of(context).goNamed(RouteNames.dashBoard);
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "WELCOME!",
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Please sign in to continue.",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                cursorColor: kPrimaryColor,
                                onSaved: (email) {},
                                decoration: const InputDecoration(
                                  hintText: "Your email",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.person),
                                  ),
                                  filled: true,
                                  fillColor: kPrimaryLightColor,
                                  iconColor: kPrimaryColor,
                                  prefixIconColor: kPrimaryColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: defaultPadding),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              if (state is UserNotFound) ...[
                                const Text("User not found")
                              ],
                              const SizedBox(height: 8),
                              Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    "Quên mật khẩu?",
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  Text("   "),
                                ],
                              ),
                              TextFormField(
                                controller: password,
                                textInputAction: TextInputAction.done,
                                obscureText: true,
                                cursorColor: kPrimaryColor,
                                decoration: const InputDecoration(
                                  hintText: "Your password",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: Icon(Icons.lock),
                                  ),
                                  filled: true,
                                  fillColor: kPrimaryLightColor,
                                  iconColor: kPrimaryColor,
                                  prefixIconColor: kPrimaryColor,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: defaultPadding),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              if (state is WrongPassword) ...[
                                const Text("Wrong Password")
                              ],
                              const SizedBox(height: defaultPadding),
                              Hero(
                                tag: "login_btn",
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: kPrimaryColor,
                                    shape: const StadiumBorder(),
                                    maximumSize:
                                        const Size(double.infinity, 56),
                                    minimumSize:
                                        const Size(double.infinity, 56),
                                  ),
                                  onPressed: () async {
                                    context.read<AuthBloc>().add(
                                          SignInRequested(
                                            LoginParam(
                                              email: email.text,
                                              password: password.text,
                                            ),
                                          ),
                                        );
                                  },
                                  child: Text(
                                    "Login".toUpperCase(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                              AlreadyHaveAnAccountCheck(
                                press: () {
                                  GoRouter.of(context)
                                      .pushNamed(RouteNames.signUp);
                                },
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Are you admin? click me.",
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    if (state is Loading) ...[
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                    if (state is AuthError) ...[
                      Text(state.error),
                    ],
                    // const Spacer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
