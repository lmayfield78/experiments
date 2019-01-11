class User {
// This is the user model.
/*
Since these variables are private, you will need to create
getters and setters.
 */
  String _userName;
  String _password;
  int _id;

  User(this._userName, this._password); // The user constructor.

  User.map(dynamic obj) {
    // Take the variables and map them to an object called obj.
    // Map = Key[value]
    this._userName = obj['username'];
    this._password = obj['password'];
    this._id = obj['id'];
  }

  // The getters.
  String get username => _userName;
  String get password => _password;
  int get id => _id;

  Map<String, dynamic> toMap() {
    /*
    This ....
     */
    var map = Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;
    map["id"] = id;

    if(id != null) {

    }

  }





}