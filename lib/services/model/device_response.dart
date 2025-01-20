class DeviceResponse {
  bool? success;
  List<DeviceModel>? deviceModeles;
  String? message;

  DeviceResponse({this.success, this.deviceModeles, this.message});

  DeviceResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      deviceModeles = <DeviceModel>[];
      json['data'].forEach((v) {
        deviceModeles!.add(new DeviceModel.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.deviceModeles != null) {
      data['data'] = this.deviceModeles!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class DeviceModel {
  int? id;
  int? businessId;
  String? serial;
  String? deviceId;
  String? deviceName;
  String? deviceCode;
  int? active;
  int? activeFromBusiness;
  String? deviceType;
  String? createdAt;
  String? updatedAt;

  DeviceModel(
      {this.id,
      this.businessId,
      this.serial,
      this.deviceId,
      this.deviceName,
      this.deviceCode,
      this.active,
      this.activeFromBusiness,
      this.deviceType,
      this.createdAt,
      this.updatedAt});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    serial = json['serial'];
    deviceId = json['device_id'];
    deviceName = json['device_name'];
    deviceCode = json['device_code'];
    active = json['active'];
    activeFromBusiness = json['active_from_business'];
    deviceType = json['device_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['serial'] = this.serial;
    data['device_id'] = this.deviceId;
    data['device_name'] = this.deviceName;
    data['device_code'] = this.deviceCode;
    data['active'] = this.active;
    data['active_from_business'] = this.activeFromBusiness;
    data['device_type'] = this.deviceType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
