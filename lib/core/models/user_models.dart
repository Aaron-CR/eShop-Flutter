class User {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;
  final String userRole;

  User({this.uid, this.email, this.displayName, this.photoURL, this.userRole});

  User.fromData(Map<String, dynamic> data)
      : uid = data['uid'],
        email = data['email'],
        displayName = data['displayName'],
        photoURL = data['photoURL'],
        userRole = data['userRole'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'userRole': userRole,
    };
  }
}
