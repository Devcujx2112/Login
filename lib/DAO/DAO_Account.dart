import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/Entity/Account.dart';
import 'package:firebase_database/firebase_database.dart';

class DAOAccount {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<void> register(Account account, String password) async {
    try {
      //Account in Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: account.email.trim(),
        password: password.trim(),
      );

      //Take uid in auth account
      String uid = userCredential.user!.uid;
      //Save data in realtime
      await _dbRef.child("Account").child(uid).set({
        "uid": uid,
        "email": account.email,
        "fullName": account.fullName,
        "role": "user",
        "createdAt": DateTime.now().toIso8601String(),
      });
      print("🔥 User đã lưu vào Firebase: $account");

    } catch (e) {
      throw Exception("Lỗi khi đăng kí: ${e.toString()}");
    }
  }
}
