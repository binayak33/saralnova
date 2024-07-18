class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? username;
  String? role;
  String? lastLogin;
  String? verfiedAt;
  String? vendorId;
  String? fcmToken;
  bool? hasHotel;
  bool? hasRestaurant;
  String? status;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.username,
    this.role,
    this.lastLogin,
    this.verfiedAt,
    this.vendorId,
    this.fcmToken,
    this.hasHotel,
    this.hasRestaurant,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    username = json['username'];
    role = json['role'];
    lastLogin = json['last_login'];
    verfiedAt = json['verified_at'];
    vendorId = json['vendor_id'];
    fcmToken = json['fcm_token'];
    hasHotel = json['has_hotel'] == 1 ? true : false;
    hasRestaurant = json['has_restaurant'] == 1 ? true : false;
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['username'] = username;
    data['role'] = role;
    data['last_login'] = lastLogin;
    data['verified_at'] = verfiedAt;
    data['vendor_id'] = vendorId;
    data['fcm_token'] = fcmToken;
    data['has_hotel'] = hasHotel;
    data['has_restaurant'] = hasRestaurant;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
