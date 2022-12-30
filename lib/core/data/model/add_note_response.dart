class AddNoteResponse {
  String? message;

  AddNoteResponse({this.message});

  AddNoteResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  AddNoteResponse.withError(String message) {
    message = message;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
