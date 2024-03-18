List<Rooms> roomFromJson(List<dynamic> roomsJson) =>
    List<Rooms>.from(roomsJson.map((roomJson) => Rooms.fromJson(roomJson)));

class Rooms {
  String? id;
  String? title;
  String? status;
  int? rate;
  String? roomTypeId;
  String? roomTypeName;
  String? createdAt;
  String? updatedAt;

  Rooms(
      {this.id,
      this.title,
      this.status,
      this.rate,
      this.roomTypeId,
      this.roomTypeName,
      this.createdAt,
      this.updatedAt});

  Rooms.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    status = json['status'];
    rate = json['rate'];
    roomTypeId = json['room_type_id'];
    roomTypeName = json['room_type_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['rate'] = this.rate;
    data['room_type_id'] = this.roomTypeId;
    data['room_type_name'] = this.roomTypeName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

