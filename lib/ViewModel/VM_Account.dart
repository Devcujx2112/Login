import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/Model/Account.dart';
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
    } catch (e) {
      throw Exception("Lỗi khi đăng kí: ${e.toString()}");
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      // Đăng nhập bằng Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (userCredential.user == null) {
        return "Mật khẩu không chính xác";
      }

      String uid = userCredential.user!.uid;

      // Lấy thông tin role từ Firebase Realtime Database
      DataSnapshot snapshot = await _dbRef.child("Account").child(uid).get();

      if (!snapshot.exists) {
        return "Không tìm thấy thông tin người dùng.";
      }

      Map<String, dynamic> userData =
          Map<String, dynamic>.from(snapshot.value as Map);
      String role = userData["role"];

      return role;
    } on FirebaseAuthException catch (e) {

      switch (e.code) {
        case 'user-not-found':
          return "Không tìm thấy tài khoản với email này.";
        case 'wrong-password':
          return "Mật khẩu không chính xác.";
        case 'invalid-email':
          return "Email không hợp lệ. Vui lòng nhập lại!";
        case 'user-disabled':
          return "Tài khoản này đã bị vô hiệu hóa.";
        case 'invalid-credential':
          return "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại!";
        default:
          return "Lỗi xác thực: ${e.message}";
      }
    } on FirebaseException catch (e) {
      return "Lỗi Firebase: ${e.message}";
    } catch (e) {
      return "Lỗi không xác định: ${e.toString()}";
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      //Email fake
      bool exists = await _checkIfEmailExists(email);
      if (!exists) {
        throw Exception("Email này chưa được đăng ký trên hệ thống.");
      }

      //Email real
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw Exception(_handleAuthException(e));
    } catch (e) {
      throw Exception("Lỗi không xác định: ${e.toString()}");
    }
  }

  Future<bool> _checkIfEmailExists(String email) async {
    try {
      //Where realtime
      DataSnapshot snapshot = await _dbRef.child("Account").get();
      if (!snapshot.exists) return false;

      Map<dynamic, dynamic> accounts = snapshot.value as Map<dynamic, dynamic>;
      for (var account in accounts.values) {
        if (account["email"] == email.trim()) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  //Log errors
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "Email không hợp lệ. Vui lòng nhập lại!";
      case 'user-not-found':
        return "Không tìm thấy tài khoản với email này.";
      default:
        return "Lỗi: ${e.message}";
    }
  }
}
