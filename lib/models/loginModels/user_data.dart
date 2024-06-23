class UserData {
  String? email, firstName, lastName, mobile, password, photo;

  UserData({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.password,
    this.photo = "",
  });

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['password'] = password;
    data['photo'] = photo;
    return data;
  }
}
