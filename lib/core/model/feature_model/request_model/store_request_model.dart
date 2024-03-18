class StoreBookinRequest {
  GuestData? guestData;
  BookingData? bookingData;
  List<int>? rooms;

  StoreBookinRequest({
    this.guestData,
    this.bookingData,
    this.rooms,
  });

  // StoreBookinRequest.fromJson(Map<String, dynamic> json) {
  //   guestData = json['guestData'] != null
  //       ? new GuestData.fromJson(json['guestData'])
  //       : null;
  //   bookingData = json['bookingData'] != null
  //       ? new BookingData.fromJson(json['bookingData'])
  //       : null;
  //   rooms = json['rooms'].cast<int>();
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.guestData != null) {
      data['guestData'] = this.guestData!.toJson();
    }
    if (this.bookingData != null) {
      data['bookingData'] = this.bookingData!.toJson();
    }
    data['rooms'] = this.rooms;
    return data;
  }
}

class GuestData {
  String? name;
  String? contact;
  String? email;
  String? address;
  String? nationality;
  String? citizenship;
  String? passport;
  String? purposeOfVisit;
  Null? document;

  GuestData(
      {this.name,
      this.contact,
      this.email,
      this.address,
      this.nationality,
      this.citizenship,
      this.passport,
      this.purposeOfVisit,
      this.document});

  // GuestData.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   contact = json['contact'];
  //   email = json['email'];
  //   address = json['address'];
  //   nationality = json['nationality'];
  //   citizenship = json['citizenship'];
  //   passport = json['passport'];
  //   purposeOfVisit = json['purpose_of_visit'];
  //   document = json['document'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['address'] = this.address;
    data['nationality'] = this.nationality;
    data['citizenship'] = this.citizenship;
    data['passport'] = this.passport;
    data['purpose_of_visit'] = this.purposeOfVisit;
    data['document'] = this.document;
    return data;
  }
}

class BookingData {
  String? checkin;
  String? checkout;
  int? totalAmount;
  String? paidAmount;
  String? discount;
  int? advanceAmount;
  int? subtotal;
  int? remainingAmount;
  String? paymentStatus;
  String? source;
  int? guestCount;
  String? specialRequests;
  int? isPackage;
  List<int>? facilities;

  BookingData(
      {this.checkin,
      this.checkout,
      this.totalAmount,
      this.paidAmount,
      this.discount,
      this.advanceAmount,
      this.subtotal,
      this.remainingAmount,
      this.paymentStatus,
      this.source,
      this.guestCount,
      this.specialRequests,
      this.isPackage,
      this.facilities});

  // BookingData.fromJson(Map<String, dynamic> json) {
  //   checkin = json['checkin'];
  //   checkout = json['checkout'];
  //   totalAmount = json['total_amount'];
  //   paidAmount = json['paid_amount'];
  //   discount = json['discount'];
  //   advanceAmount = json['advance_amount'];
  //   subtotal = json['subtotal'];
  //   remainingAmount = json['remaining_amount'];
  //   paymentStatus = json['payment_status'];
  //   source = json['source'];
  //   guestCount = json['guest_count'];
  //   specialRequests = json['special_requests'];
  //   isPackage = json['is_package'];
  //   facilities = json['facilities'].cast<int>();
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['discount'] = this.discount;
    data['advance_amount'] = this.advanceAmount;
    data['subtotal'] = this.subtotal;
    data['remaining_amount'] = this.remainingAmount;
    data['payment_status'] = this.paymentStatus;
    data['source'] = this.source;
    data['guest_count'] = this.guestCount;
    data['special_requests'] = this.specialRequests;
    data['is_package'] = this.isPackage;
    data['facilities'] = this.facilities;
    return data;
  }
}
