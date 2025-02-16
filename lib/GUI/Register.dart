import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/Entity/Account.dart';
import '../DAO/DAO_Account.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final TextEditingController _txtFullName = TextEditingController();
  final DAOAccount _daoAccount = DAOAccount();

  bool _emailError = false;
  bool _passwordError = false;
  bool _nameError = false;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  //Check email
  bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  //Validate input user
  void ValidateInput() {
    setState(() {
      _emailError = _txtEmail.text.isEmpty || !isValidEmail(_txtEmail.text);
      _passwordError =
          _txtPassword.text.isEmpty || _txtPassword.text.length < 6;
      _nameError = _txtFullName.text.isEmpty;
    });

    if (_emailError || _passwordError || _nameError) {
      return;
    }
  }

  //Hint input focus
  @override
  void initState() {
    super.initState();

    _emailFocus.addListener(() {
      if (_emailFocus.hasFocus) {
        setState(() {
          _emailError = false;
        });
      }
    });

    _passwordFocus.addListener(() {
      if (_passwordFocus.hasFocus) {
        setState(() {
          _passwordError = false;
        });
      }
    });

    _nameFocus.addListener(() {
      if (_nameFocus.hasFocus) {
        setState(() {
          _nameError = false;
        });
      }
    });
  }

  //Register account
  Future<void> _register() async {
    ValidateInput();
    String inputEmail = _txtEmail.text.toString();
    String inputPassword = _txtPassword.text.toString();
    String inputFullname = _txtFullName.text.toString();
    Account account = Account(inputEmail, inputFullname);
    try {
      await _daoAccount.register(
        account,
        inputPassword,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Đăng ký thành công!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Màu nền tối
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Devcujx Company",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 100)),
              ],
            ),
            const SizedBox(height: 70),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 5)),
                  Text(
                    "Work hard, play hard",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _txtEmail,
              focusNode: _emailFocus,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black54,
                hintText: "Your Email Address",
                errorText: _emailError
                    ? (_txtEmail.text.isEmpty
                        ? 'Email không được để trống'
                        : 'Email không hợp lệ')
                    : null,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            const SizedBox(height: 12),
            TextField(
              controller: _txtPassword,
              focusNode: _passwordFocus,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black54,
                hintText: "Password",
                errorText: _passwordError
                    ? (_txtPassword.text.isEmpty
                        ? 'Password không được để trống'
                        : 'Password phải có ít nhất 6 kí tự')
                    : null,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            const SizedBox(height: 12),
            TextField(
              controller: _txtFullName,
              focusNode: _nameFocus,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black54,
                hintText: "Full Name",
                errorText: _nameError ? 'Full Name không được để trống' : null,
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4B39EF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0x4C4B39EF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Back to login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 30))
          ],
        ),
      ),
    );
  }
}
