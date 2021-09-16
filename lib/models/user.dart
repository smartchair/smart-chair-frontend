class User {
  int? id;
  String? email;
  String? password;
  Map<String, dynamic>? chairs = Map<String, dynamic>();

  User();

  User.toLogIn({this.email, this.password});

  User.toCreate({this.email, this.password, this.chairs});

  String loginToJson() {
    return '{"username": "${this.email}", "password": "${this.password}"}';
  }

  String createToJson() {
    return '{"email": "${this.email}", "password": "${this.password}", "chairs": ${this.chairs}}';
  }
}
