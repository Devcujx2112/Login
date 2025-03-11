import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/Helpers/Validate_input.dart';
import 'package:login/Model/Account.dart';
import '../ViewModel/VM_Account.dart';
import 'GoogleMapSeller.dart';
import 'Login.dart';

class RegisterSeller extends StatefulWidget {
  const RegisterSeller({super.key});

  @override
  State<RegisterSeller> createState() => _RegisterStateSeller();
}

class _RegisterStateSeller extends State<RegisterSeller> {
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final TextEditingController _txtFullName = TextEditingController();

  final DAOAccount _daoAccount = DAOAccount();

  String? _emailError;
  String? _passwordError;
  String? _nameError;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    FocusHelper.setupFocusListeners(
      focusNode: _emailFocus,
      onFocusGained: () => setState(() => _emailError = null),
    );

    FocusHelper.setupFocusListeners(
      focusNode: _passwordFocus,
      onFocusGained: () => setState(() => _passwordError = null),
    );

    FocusHelper.setupFocusListeners(
      focusNode: _nameFocus,
      onFocusGained: () => setState(() => _nameError = null),
    );
  }

  //Validate input user
  void ValidateInput() {
    setState(() {
      _emailError = Validators.validateEmail(_txtEmail.text.toString());
      _passwordError = Validators.validatePassword(_txtPassword.text.toString());
      _nameError = Validators.validateFullName(_txtFullName.text.toString());
    });
  }

  //Register account
  Future<void> _Register() async {
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                errorText: _emailError,
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
                errorText: _passwordError,
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
                errorText: _nameError,
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
                    onPressed: _Register,
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
                        MaterialPageRoute(builder: (context) => Googlemapseller()));
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
