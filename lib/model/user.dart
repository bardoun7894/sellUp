class User {
  int _id;
  String _email ;
  String _password ;
  String _name ;
  String _profileImage ;
  String _phone ;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get email => _email;

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get profileImage => _profileImage;

  set profileImage(String value) {
    _profileImage = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  set email(String value) {
    _email = value;
  }


}
