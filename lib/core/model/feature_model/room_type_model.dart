List<RoomType> roomTypeFromJson(List<dynamic> roomTypesJson) =>
    List<RoomType>.from(
        roomTypesJson.map((roomTypeJson) => RoomType.fromJson(roomTypeJson)));

class RoomType {
  String? id;
  String? title;
  String? vendorId;
  String? createdAt;
  String? updatedAt;

  RoomType(
      {this.id, this.title, this.vendorId, this.createdAt, this.updatedAt});

  RoomType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vendorId = json['vendor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['vendor_id'] = this.vendorId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
