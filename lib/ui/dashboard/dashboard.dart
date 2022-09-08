import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_sm/blocs/auth_bloc/auth_bloc.dart';
import 'package:home_sm/core/router/routes.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("this is dashboard"),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () {
                // Signing out the user

                GoRouter.of(context).goNamed(RouteNames.signIn);
                context.read<AuthBloc>().add(SignOutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}
