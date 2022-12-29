class RegisterResponse {
  RegisterResponse({
    this.message,
  });

  RegisterResponse.fromJson(dynamic json) {
    message = json['message'];
  }

  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

  RegisterResponse.withError(String errorMessage) {
    message = errorMessage;
  }
}
