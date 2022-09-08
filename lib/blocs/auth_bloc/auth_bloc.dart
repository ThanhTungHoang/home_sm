// ignore: import_of_legacy_library_into_null_safe
import 'dart:developer';

// ignore: import_of_legacy_library_into_null_safe
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_sm/models/login/login_model.dart';
import 'package:home_sm/resources/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignInRequested>(
      (event, emit) async {
        emit(Loading());
        final response = await authRepository.signIn(
          LoginParam(
              email: event.loginParam.email,
              password: event.loginParam.password),
        );
        log("response: $response");
        if (response == "login_success") {
          emit(Authenticated());
        }
        if (response == "wrong_password") {
          // emit(AuthError(response.toString()));
          emit(WrongPassword());
        }
        if (response == "user_not_found") {
          emit(UserNotFound());
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
      try {
        await authRepository.signUp(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}
