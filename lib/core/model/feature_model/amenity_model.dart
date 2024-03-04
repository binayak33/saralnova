List<Amenity> amenitiesFromJson(List<dynamic> amenitiesJson) =>
    List<Amenity>.from(
        amenitiesJson.map((aminityJson) => Amenity.fromJson(aminityJson)));

class Amenity {
  String? id;
  String? vendorId;
  String? title;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Amenity(
      {this.id,
      this.vendorId,
      this.title,
      this.createdAt,
      this.updatedAt,
      this.imageUrl});

  Amenity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
