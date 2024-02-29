List<Facility> facilitiesFromJson(List<dynamic> facilitiesJson) =>
    List<Facility>.from(
        facilitiesJson.map((facilityJson) => Facility.fromJson(facilityJson)));

class Facility {
  int? id;
  int? vendorId;
  String? title;
  num? price;
  String? createdAt;
  String? updatedAt;

  Facility(
      {this.id,
      this.vendorId,
      this.title,
      this.price,
      this.createdAt,
      this.updatedAt});

  Facility.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
