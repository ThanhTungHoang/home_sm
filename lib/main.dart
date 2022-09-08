import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_sm/blocs/auth_bloc/auth_bloc.dart';
import 'package:home_sm/core/app_colors.dart';
import 'package:home_sm/core/bloc_obsever.dart';
import 'package:home_sm/core/router/routes.dart';
import 'package:home_sm/core/service/firebase_options.dart';
import 'package:home_sm/resources/auth_repository.dart';
import 'package:home_sm/ui/sign_in/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp.router(
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.colorBackground,
            fontFamily: 'NotoSans',
          ),
          debugShowCheckedModeBanner: false,
          routeInformationProvider: Routes.route.routeInformationProvider,
          routeInformationParser: Routes.route.routeInformationParser,
          routerDelegate: Routes.route.routerDelegate,
          title: 'GoRouter',
        ),
      ),
    );
  }
}

// goName: Đi ko trở lại
// pushName: Đi để trở về