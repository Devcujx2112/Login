class Account{
  late String _email;
  late String _fullName;
  late String _role;

  Account(this._email, this._fullName, this._role);

  String get role => _role;

  set role(String value) {
    _role = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  @override
  String toString() {
    return 'Account{_email: $_email, _fullName: $_fullName, _role: $_role}';
  }
}