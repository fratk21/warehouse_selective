import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class auth_services {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _res = "Some error Occurred";
  Future<String?> login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _res = "ok";
      } else {
        _res = "Lütfen Tüm Alanları Doldurunuz";
      }
    } catch (err) {
      _res = err.toString();
      return _res;
    }

    return _res;
  }

  Future<String?> register(
      String username, String email, String password, String phone) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred);
        await _firestore.collection("users").doc(cred.user!.uid).set({
          "username": username,
          "email": email,
        });

        _res = "Success";
      } else {}
    } catch (e) {
      print(e);
    }
  }

  Future<String?> ResetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.toString());
  }
}
