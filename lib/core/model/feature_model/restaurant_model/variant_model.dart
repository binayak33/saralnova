List<Variant> restaurantVariantsJson(List<dynamic> variantsJson) =>
    List<Variant>.from(
        variantsJson.map((variantJson) => Variant.fromJson(variantJson)));

class Variant {
  String? id;
  String? title;
  String? vendorId;
  int? price;
  String? type;
  String? description;
  String? createdAt;
  String? updatedAt;

  Variant(
      {this.id,
      this.title,
      this.vendorId,
      this.price,
      this.type,
      this.description,
      this.createdAt,
      this.updatedAt});

  Variant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vendorId = json['vendor_id'];
    price = json['price'];
    type = json['type'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['vendor_id'] = this.vendorId;
    data['price'] = this.price;
    data['type'] = this.type;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
