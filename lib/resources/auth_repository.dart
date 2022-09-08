import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_sm/models/login/login_model.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> signIn(LoginParam loginParam) async {
    try {
      final a = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginParam.email, password: loginParam.password);
      print(a.toString());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'user-not-found') {
        return 'user_not_found';
      }
      if (e.code == 'too-many-requests') {
        return 'too_many_requests';
      }
      if (e.code == 'network-request-failed') {
        return 'network_request_failed';
      } else if (e.code == 'wrong-password') {
        return 'wrong_password';
      }
    }

    return "login_success";
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
