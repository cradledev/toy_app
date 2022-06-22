class UserModel {
  final int id;
  final String userName;
  final String userEmail;
  final String firstName;
  final String lastName;
  final String bio;
  final String path;
  final int customerId;
  final bool active;
  final String pass;
  final bool isGuest;
  final String token;
  UserModel({
    this.id,
    this.userName,
    this.userEmail,
    this.firstName,
    this.lastName,
    this.bio,
    this.path,
    this.customerId,
    this.active,
    this.pass,
    this.isGuest,
    this.token
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    String _username = json['username'] ?? "";
    String _useremail = json['email'] ?? "";
    String _firstname = json['first_name'] ?? "";
    String _lastname = json['last_name'] ?? "";
    String _bio = json['admin_comment'] ?? "";
    String _path = json['system_name'] ?? "";
    String _pass = json['last_ip_address'] ?? "";
    return UserModel(
      id: json['id'],
      userName: _username,
      userEmail: _useremail,
      firstName: _firstname,
      lastName: _lastname,
      bio: _bio,
      path: _path,
      customerId: json['customer_id'],
      active: json['active'],
      pass: _pass,
      isGuest: json['is_guest'] ?? false,
      token: json['token']
    );
  }

   Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userName": userName,
      "userEmail": userEmail,
      "firstName": firstName,
      "lastName": lastName,
      "bio": bio,
      "path": path,
      "customerId" : customerId,
      "active" : active,
      "pass" : pass,
      "isGuest" : isGuest,
      "token" : token
    };
  }
}
