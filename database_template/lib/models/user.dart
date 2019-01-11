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
    This method creates a map and assigns the variables
    into the map.
     */
    var map = Map<String, dynamic>(); // creates map with string : dynamic values.
    map["username"] = username; // sets the map value from the getter username var.
    map["password"] = password; // sets the map value from the getter password var.
    if(id != null) { // verifies if the id comes from the db. sets map value from getter var.
      map["id"] = _id;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    /*
    TODO: Explain what this function does.
     */
    this._userName = map["username"];
    this._password = map["password"];
    this._id = map["id"];

  }





}