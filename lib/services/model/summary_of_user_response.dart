class DetailSummaryResponse {
  bool? success;
  DetailSummaryModel? summaryOfUserModel;
  String? message;

  DetailSummaryResponse({this.success, this.summaryOfUserModel, this.message});

  DetailSummaryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    summaryOfUserModel = json['data'] != null
        ? new DetailSummaryModel.fromJson(json['data'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.summaryOfUserModel != null) {
      data['data'] = this.summaryOfUserModel!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class DetailSummaryModel {
  num? totalCash;
  num? nCash;
  num? cash;
  num? card;
  num? total;

  DetailSummaryModel(
      {this.totalCash, this.nCash, this.cash, this.card, this.total});

  DetailSummaryModel.fromJson(Map<String, dynamic> json) {
    totalCash = json['total_cash'];
    nCash = json['n_cash'];
    cash = json['cash'];
    card = json['card'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_cash'] = this.totalCash;
    data['n_cash'] = this.nCash;
    data['cash'] = this.cash;
    data['card'] = this.card;
    data['total'] = this.total;
    return data;
  }
}
