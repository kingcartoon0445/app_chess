class SummaryResponse {
  bool? success;
  SummaryModel? summaryModel;
  String? message;

  SummaryResponse({this.success, this.summaryModel, this.message});

  SummaryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    summaryModel =
        json['data'] != null ? new SummaryModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> summaryModel = new Map<String, dynamic>();
    summaryModel['success'] = this.success;
    if (this.summaryModel != null) {
      summaryModel['data'] = this.summaryModel!.toJson();
    }
    summaryModel['message'] = this.message;
    return summaryModel;
  }
}

class SummaryModel {
  List<Users>? users;
  num? total;

  SummaryModel({this.users, this.total});

  SummaryModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> summaryModel = new Map<String, dynamic>();
    if (this.users != null) {
      summaryModel['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    summaryModel['total'] = this.total;
    return summaryModel;
  }
}

class Users {
  String? userName;
  num? total;

  Users({this.userName, this.total});

  Users.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> summaryModel = new Map<String, dynamic>();
    summaryModel['user_name'] = this.userName;
    summaryModel['total'] = this.total;
    return summaryModel;
  }
}
