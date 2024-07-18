class HotelDashboard {
  int? roomCount;
  int? availableRoomsCount;
  int? newBookingCount;
  int? totalBookingCount;
  int? totalGuestCount;
  int? occupiedRooms;
  int? vacantRooms;
  int? reservedRooms;
  int? cancelledCount;

  HotelDashboard(
      {this.roomCount,
      this.availableRoomsCount,
      this.newBookingCount,
      this.totalBookingCount,
      this.totalGuestCount,
      this.occupiedRooms,
      this.vacantRooms,
      this.reservedRooms,
      this.cancelledCount});

  HotelDashboard.fromJson(Map<String, dynamic> json) {
    roomCount = json['roomCount'];
    availableRoomsCount = json['availableRoomsCount'];
    newBookingCount = json['newBookingCount'];
    totalBookingCount = json['totalBookingCount'];
    totalGuestCount = json['totalGuestCount'];
    occupiedRooms = json['occupiedRooms'];
    vacantRooms = json['vacantRooms'];
    reservedRooms = json['reservedRooms'];
    cancelledCount = json['cancelledCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomCount'] = this.roomCount;
    data['availableRoomsCount'] = this.availableRoomsCount;
    data['newBookingCount'] = this.newBookingCount;
    data['totalBookingCount'] = this.totalBookingCount;
    data['totalGuestCount'] = this.totalGuestCount;
    data['occupiedRooms'] = this.occupiedRooms;
    data['vacantRooms'] = this.vacantRooms;
    data['reservedRooms'] = this.reservedRooms;
    data['cancelledCount'] = this.cancelledCount;
    return data;
  }
}
