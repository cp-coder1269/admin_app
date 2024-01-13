class AdminDetailModel {
  bool? success;
  String? message;
  Data? data;

  AdminDetailModel({this.success, this.message, this.data});

  AdminDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserData? userData;
  List<RequestData>? requestData;
  Null? actionData;

  Data({this.userData, this.requestData, this.actionData});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    if (json['request_data'] != null) {
      requestData = <RequestData>[];
      json['request_data'].forEach((v) {
        requestData!.add(new RequestData.fromJson(v));
      });
    }
    actionData = json['action_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    if (this.requestData != null) {
      data['request_data'] = this.requestData!.map((v) => v.toJson()).toList();
    }
    data['action_data'] = this.actionData;
    return data;
  }
}

class UserData {
  int? userId;
  String? info;

  UserData({this.userId, this.info});

  UserData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['info'] = this.info;
    return data;
  }
}

class RequestData {
  int? id;
  int? userIdFk;
  String? expectedSalary;
  String? status;
  String? updateTime;
  String? name;
  String? email;

  RequestData(
      {this.id,
      this.userIdFk,
      this.expectedSalary,
      this.status,
      this.updateTime,
      this.name,
      this.email});

  RequestData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userIdFk = json['user_id_fk'];
    expectedSalary = json['expectedSalary'];
    status = json['status'];
    updateTime = json['updateTime'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id_fk'] = this.userIdFk;
    data['expectedSalary'] = this.expectedSalary;
    data['status'] = this.status;
    data['updateTime'] = this.updateTime;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
