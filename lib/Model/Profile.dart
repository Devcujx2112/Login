class Profile{
  late String _id;
  late double _latitude;
  late double _longitude;

  Profile(this._id, this._latitude, this._longitude);

  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  double get latitude => _latitude;

  set latitude(double value) {
    _latitude = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}