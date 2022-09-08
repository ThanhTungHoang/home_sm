import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_sm/blocs/auth_bloc/auth_bloc.dart';
import 'package:home_sm/core/constants.dart';
import 'package:home_sm/core/router/routes.dart';
import 'package:home_sm/models/login/login_model.dart';
import 'package:home_sm/ui/sign_in/components/already_have_an_account_acheck.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                            "Sign In",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Please enter the information to continue.",
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
                      // if (state is UserNotFound) ...[
                      //   const Text("User not found")
                      // ],
                      const SizedBox(height: 8),

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
                      // if (state is WrongPassword) ...[
                      //   const Text("Wrong Password")
                      // ],
                      const SizedBox(height: defaultPadding),
                      Hero(
                        tag: "login_btn",
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: kPrimaryColor,
                            shape: const StadiumBorder(),
                            maximumSize: const Size(double.infinity, 56),
                            minimumSize: const Size(double.infinity, 56),
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
                            "Register Now".toUpperCase(),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          GoRouter.of(context).pushNamed(RouteNames.signIn);
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),

            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
