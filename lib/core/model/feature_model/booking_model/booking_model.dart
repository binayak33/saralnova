import 'guest_model.dart';
import 'payment_model.dart';
import 'room_occupancies_model.dart';

class Booking {
  int? id;
  int? vendorId;
  int? guestId;
  String? checkin;
  String? checkout;
  int? totalAmount;
  int? subtotal;
  int? paidAmount;
  int? remainingAmount;
  int? advanceAmount;
  int? discount;
  String? source;
  int? guestCount;
  String? paymentStatus;
  String? specialRequests;
  String? facilities;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? cancelledAt;
  int? isPackage;
  Payments? payments;
  // List<String>? extraPayments;//TODO fix this type
  Guest? guest;
  List<RoomOccupancies>? roomOccupancies;

  Booking(
      {this.id,
      this.vendorId,
      this.guestId,
      this.checkin,
      this.checkout,
      this.totalAmount,
      this.subtotal,
      this.paidAmount,
      this.remainingAmount,
      this.advanceAmount,
      this.discount,
      this.source,
      this.guestCount,
      this.paymentStatus,
      this.specialRequests,
      this.facilities,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.cancelledAt,
      this.isPackage,
      this.payments,
      // this.extraPayments,
      this.guest,
      this.roomOccupancies});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    guestId = json['guest_id'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    totalAmount = json['total_amount'];
    subtotal = json['subtotal'];
    paidAmount = json['paid_amount'];
    remainingAmount = json['remaining_amount'];
    advanceAmount = json['advance_amount'];
    discount = json['discount'];
    source = json['source'];
    guestCount = json['guest_count'];
    paymentStatus = json['payment_status'];
    specialRequests = json['special_requests'];
    facilities = json['facilities'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    cancelledAt = json['cancelled_at'];
    isPackage = json['is_package'];
    payments = json['payments'] != null
        ? new Payments.fromJson(json['payments'])
        : null;
    // if (json['extra_payments'] != null) {
    //   extraPayments = <String>[];
    //   json['extra_payments'].forEach((v) {
    //     extraPayments!.add(new String.fromJson(v));
    //   });
    // }
    guest = json['guest'] != null ? new Guest.fromJson(json['guest']) : null;
    if (json['room_occupancies'] != null) {
      roomOccupancies = <RoomOccupancies>[];
      json['room_occupancies'].forEach((v) {
        roomOccupancies!.add(new RoomOccupancies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['guest_id'] = this.guestId;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['total_amount'] = this.totalAmount;
    data['subtotal'] = this.subtotal;
    data['paid_amount'] = this.paidAmount;
    data['remaining_amount'] = this.remainingAmount;
    data['advance_amount'] = this.advanceAmount;
    data['discount'] = this.discount;
    data['source'] = this.source;
    data['guest_count'] = this.guestCount;
    data['payment_status'] = this.paymentStatus;
    data['special_requests'] = this.specialRequests;
    data['facilities'] = this.facilities;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['cancelled_at'] = this.cancelledAt;
    data['is_package'] = this.isPackage;
    if (this.payments != null) {
      data['payments'] = this.payments!.toJson();
    }
    // if (this.extraPayments != null) {
    //   data['extra_payments'] =
    //       this.extraPayments!.map((v) => v.toJson()).toList();
    // }
    if (this.guest != null) {
      data['guest'] = this.guest!.toJson();
    }
    if (this.roomOccupancies != null) {
      data['room_occupancies'] =
          this.roomOccupancies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

