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



// class Rooms {
//   int? id;
//   int? vendorId;
//   String? title;
//   String? status;
//   int? rate;
//   String? createdAt;
//   String? updatedAt;
//   RoomType? roomType;

//   Rooms({
//     this.id,
//     this.vendorId,
//     // this.type,
//     this.title,
//     this.status,
//     this.rate,
//     this.createdAt,
//     this.updatedAt,
//     this.roomType,
//   });

//   Rooms.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     vendorId = json['vendor_id'];
//     title = json['title'];
//     status = json['status'];
//     rate = json['rate'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     roomType =
//         json['room_type'] != null ? RoomType.fromJson(json['room_type']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['vendor_id'] = this.vendorId;
//     // data['type'] = this.type;
//     data['title'] = this.title;
//     data['status'] = this.status;
//     data['rate'] = this.rate;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (roomType != null) {
//       data['room_type'] = roomType!.toJson();
//     }
//     return data;
//   }
// }
