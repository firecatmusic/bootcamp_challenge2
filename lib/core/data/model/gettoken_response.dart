class GetTokenResponse {
  String? message;
  String? token;

  GetTokenResponse({this.message, this.token});

  GetTokenResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }

  GetTokenResponse.withError(String errorMessage) {
    message = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}