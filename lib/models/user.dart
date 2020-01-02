class Roles {
  bool editor;
  bool admin;
}

class User {
  final String uid;
  String email;
  String password;
  String displayName;
  String photoURL;
  Roles roles;

  User(
      {this.uid,
      this.email,
      this.displayName,
      this.photoURL,
      this.roles});
}
