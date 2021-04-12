class UserModel {
  String email;
  String password;

  UserModel({
    this.email,
    this.password,
  });

  UserModel.fromJsonMap(Map<String, dynamic> user) {
    this.email = (user["email"]);
    this.password = user["password"];
  }
}
