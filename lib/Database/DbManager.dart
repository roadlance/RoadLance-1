import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future saveUserData(String firstName, String lastName, String fullName,
      String email, String phoneNumber) {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('Users');

    return usersRef
        .doc(auth.currentUser.uid)
        .set({
          'FirstName': firstName,
          'LastName': lastName,
          'FullName': fullName,
          'Email': email,
          'PhoneNumber': phoneNumber,
          'CurrentBalance': 0,
        })
        .then((value) => print("User data saved to Firestore"))
        .catchError((error) => print("Failed to add user data: $error"));
  }
}
