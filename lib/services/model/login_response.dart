// login_response.dart

class LoginResponse {
  final bool success;
  final LoginData? loginData;
  final String message;

  LoginResponse({
    required this.success,
    this.loginData,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      loginData: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': loginData?.toJson(),
      'message': message,
    };
  }
}

class LoginData {
  final Business business;
  final User user;

  LoginData({
    required this.business,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      business: Business.fromJson(json['business']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'business': business.toJson(),
      'user': user.toJson(),
    };
  }
}

class Business {
  final int id;
  final String name;
  final String code;
  final dynamic startDate;
  final int ownerId;
  final dynamic logo;
  final int isActive;
  final String expiryDate;
  final dynamic description;
  final dynamic address;
  final dynamic phone;
  final dynamic lat;
  final dynamic long;
  final dynamic plz;
  final dynamic city;
  final dynamic taxNo;
  final dynamic email;
  final int currencyId;
  final String timeZone;
  final dynamic databaseUrl;
  final dynamic invoiceTemplate;
  final dynamic kitchenTemplate;
  final String businessType;
  final int maxDevice;
  final int usingPos;
  final String createdAt;
  final String updatedAt;

  Business({
    required this.id,
    required this.name,
    required this.code,
    this.startDate,
    required this.ownerId,
    this.logo,
    required this.isActive,
    required this.expiryDate,
    this.description,
    this.address,
    this.phone,
    this.lat,
    this.long,
    this.plz,
    this.city,
    this.taxNo,
    this.email,
    required this.currencyId,
    required this.timeZone,
    this.databaseUrl,
    this.invoiceTemplate,
    this.kitchenTemplate,
    required this.businessType,
    required this.maxDevice,
    required this.usingPos,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      startDate: json['start_date'],
      ownerId: json['owner_id'] ?? 0,
      logo: json['logo'],
      isActive: json['is_active'] ?? 0,
      expiryDate: json['expiry_date'] ?? '',
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      lat: json['lat'],
      long: json['long'],
      plz: json['plz'],
      city: json['city'],
      taxNo: json['tax_no'],
      email: json['email'],
      currencyId: json['currency_id'] ?? 0,
      timeZone: json['time_zone'] ?? '',
      databaseUrl: json['databaseUrl'],
      invoiceTemplate: json['invoice_template'],
      kitchenTemplate: json['kitchen_template'],
      businessType: json['business_type'] ?? '',
      maxDevice: json['max_device'] ?? 0,
      usingPos: json['using_pos'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'start_date': startDate,
      'owner_id': ownerId,
      'logo': logo,
      'is_active': isActive,
      'expiry_date': expiryDate,
      'description': description,
      'address': address,
      'phone': phone,
      'lat': lat,
      'long': long,
      'plz': plz,
      'city': city,
      'tax_no': taxNo,
      'email': email,
      'currency_id': currencyId,
      'time_zone': timeZone,
      'databaseUrl': databaseUrl,
      'invoice_template': invoiceTemplate,
      'kitchen_template': kitchenTemplate,
      'business_type': businessType,
      'max_device': maxDevice,
      'using_pos': usingPos,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class User {
  final int id;
  final String code;
  final String name;
  final String username;
  final String password;
  final String apiToken;
  final String status;
  final dynamic deviceLogin;
  final dynamic createdAt;
  final dynamic deletedAt;
  final dynamic updatedAt;

  User({
    required this.id,
    required this.code,
    required this.name,
    required this.username,
    required this.password,
    required this.apiToken,
    required this.status,
    this.deviceLogin,
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      apiToken: json['api_token'] ?? '',
      status: json['status'] ?? '',
      deviceLogin: json['device_login'],
      createdAt: json['created_at'],
      deletedAt: json['deleted_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'username': username,
      'password': password,
      'api_token': apiToken,
      'status': status,
      'device_login': deviceLogin,
      'created_at': createdAt,
      'deleted_at': deletedAt,
      'updated_at': updatedAt,
    };
  }
}
