import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  FirebaseAuth auth = FirebaseAuth.instance;

  login(String email, String password) {}

  register(String firstName, String lastName, String email, String password) {}
}
