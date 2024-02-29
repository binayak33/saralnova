List<Room> roomFromJson(List<dynamic> roomsJson) =>
    List<Room>.from(roomsJson.map((roomJson) => Room.fromJson(roomJson)));

class Room {
  int? id;
  String? title;
  int? vendorId;
  String? createdAt;
  String? updatedAt;

  Room({this.id, this.title, this.vendorId, this.createdAt, this.updatedAt});

  Room.fromJson(Map<String, dynamic> json) {
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
