class Account {
  late String _uid;
  late String _email;
  late String _fullName;
  late String _role;
  late DateTime _createdAt;

  Account(this._email, this._fullName) {
    _role = 'user';
    _createdAt = DateTime.now();
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

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

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  @override
  String toString() {
    return 'Account{email: $_email, fullName: $_fullName, role: $_role, createdAt: $_createdAt}';
  }
}
