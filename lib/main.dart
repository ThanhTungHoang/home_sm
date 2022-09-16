import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_sm/core/bloc_obsever.dart';
import 'package:home_sm/core/service/firebase_options.dart';
import 'app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      runApp(const AppRoot());
    },
    blocObserver: SimpleBlocObserver(),
  );
}
// goName: Đi ko trở lại
// pushName: Đi để trở về