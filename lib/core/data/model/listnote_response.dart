class ListNoteResponse {
  String? message;
  List<DataNote>? data;

  ListNoteResponse({this.message, this.data});

  ListNoteResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <DataNote>[];
      json['data'].forEach((v) {
        data?.add(DataNote.fromJson(v));
      });
    }
  }

  ListNoteResponse.withError(String errorMessage){
    message = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataNote {
  String? id;
  String? title;
  String? content;
  int? createdAt;
  int? updatedAt;

  DataNote({this.id, this.title, this.content, this.createdAt, this.updatedAt});

  DataNote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
