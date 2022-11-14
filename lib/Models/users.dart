class UserModel {
  String? name;
  String? email;
  String? wrool;
  String? uid;

// receiving data
  UserModel({this.name, this.uid, this.email, this.wrool, });
  factory UserModel.fromMap(map) {
    return UserModel(
      name: map['name'],
      uid: map['uid'],
      email: map['email'],
      wrool: map['wrool'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'wrool': wrool,
    };
  }
}
