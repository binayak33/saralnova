import '../../rooms_model.dart';

List<RoomOccupancies> roomFromJson(List<dynamic> roomsOccupanciesJson) =>
    List<RoomOccupancies>.from(roomsOccupanciesJson.map(
        (roomOccupancyJson) => RoomOccupancies.fromJson(roomOccupancyJson)));

class RoomOccupancies {
  int? id;
  int? vendorId;
  int? bookingId;
  int? roomId;
  String? date;
  int? rate;
  String? status;
  String? createdAt;
  String? updatedAt;
  Rooms? room;

  RoomOccupancies({
    this.id,
    this.vendorId,
    this.bookingId,
    this.roomId,
    this.date,
    this.rate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.room,
  });

  RoomOccupancies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    bookingId = json['booking_id'];
    roomId = json['room_id'];
    date = json['date'];
    rate = json['rate'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    room = json['room'] != null ? new Rooms.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['booking_id'] = this.bookingId;
    data['room_id'] = this.roomId;
    data['date'] = this.date;
    data['rate'] = this.rate;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    return data;
  }
}
