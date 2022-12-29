class LoginResponse {
  String? message;
  DataLogin? data;
  String? token;

  LoginResponse({this.message, this.data, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? DataLogin.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }

  LoginResponse.withError(String errorMessage) {
    message = errorMessage;
  }
}

class DataLogin {
  String? id;
  String? name;
  String? email;
  String? photo;

  DataLogin({this.id, this.name, this.email, this.photo});

  DataLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    return data;
  }
}
