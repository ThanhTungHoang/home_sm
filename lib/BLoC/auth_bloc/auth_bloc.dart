// ignore: import_of_legacy_library_into_null_safe
import 'dart:developer';

// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_sm/models/login/login_model.dart';
import 'package:home_sm/models/signup/signup_model.dart';
import 'package:home_sm/resources/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<CheckLogin>(
      (event, emit) {
        if (FirebaseAuth.instance.currentUser != null) {
          emit(Authenticated());
        } else {
          emit(UnAuthenticated());
        }
      },
    );

    on<SignInRequested>(
      (event, emit) async {
        emit(Loading());
        final response = await authRepository.signIn(
          LoginParam(
              email: event.loginParam.email,
              password: event.loginParam.password),
        );
        log("response in bloc: $response");

        if (response == "login_success-true") {
          emit(Authenticated());
        }
        if (response == "login_success-false") {
          emit(DialogNotification("Please verify the email in the mailbox"));
        }
        if (response == "wrong_password") {
          emit(ResponsePassword("Wrong password"));
        }
        if (response == "user_not_found") {
          emit(ResponseEmail("User not found"));
        }
        if (response == "too_many_requests") {
          emit(AuthError("Phat hien truy cp baat thuwowng, block!"));
        }
        if (response == "network_request_failed") {
          emit(AuthError("mang co van de, xin hay kiem tra lai"));
        }
      },
    );

    on<SignUpRequested>((event, emit) async {
      emit(Loading());

      if (event.signUpParam.password == event.rePassword) {
        final response = await authRepository.signUp(SignUpParam(
            email: event.signUpParam.email,
            password: event.signUpParam.password));
        log("response: $response");

        if (response == 'signup_success') {
          await authRepository.createUserData(event.fullName);
          emit(DialogNotification(
              "Sucssec. Please verify the email in the mailbox"));
        }
        if (response == 'email-already-in-use') {
          emit(ResponseEmail("Email already in use"));
        }
        if (response == "too_many_requests") {
          emit(AuthError("Phat hien truy cp baat thuwowng, block!"));
        }
        if (response == "network_request_failed") {
          emit(AuthError("mang co van de, xin hay kiem tra lai"));
        }
      } else {
        emit(ResponsePassword("Password does not match"));
      }
    });
    on<SendEmailForgotPassword>((event, emit) async {
      emit(Loading());
      final response = await authRepository.forgotPassword(email: event.email);
      log(response);
      if (response == 'send_Email_Done') {
        emit(AuthError("Sucsec. Please check mailbox!"));
      }
      if (response == 'user_not_found') {
        emit(ResponseEmail("User not found"));
      }
      if (response == "too_many_requests") {
        emit(AuthError("Phat hien truy cp baat thuwowng, block!"));
      }
      if (response == "network_request_failed") {
        emit(AuthError("mang co van de, xin hay kiem tra lai"));
      }
    });

    on<SignOutRequested>(
      (event, emit) async {
        emit(Loading());
        await authRepository.signOut();
        emit(UnAuthenticated());
      },
    );
    on<ResetState>(
      ((event, emit) {
        emit(UnAuthenticated());
      }),
    );
  }
}
