import 'package:saralnova/core/model/feature_model/order/order_items_model.dart';
import 'package:saralnova/core/model/feature_model/pos/order_customers_model.dart';

List<OrderModel> ordersFromJson(List<dynamic> ordersJson) =>
    List<OrderModel>.from(
        ordersJson.map((orderJson) => OrderModel.fromJson(orderJson)));

class OrderModel {
  String? id;
  String? vendorId;
  String? vendorName;
  String? vendorAddress;
  String? vendorPhone;
  String? vendorImage;
  Customer? restaurantCustomer;
  int? salesTotal;
  int? discount;
  int? total;
  bool? isPaid;
  String? paymentMethod;
  String? paidBy;
  List<OrderItems>? items;
  String? createdAt;
  String? updatedAt;

  OrderModel(
      {this.id,
      this.vendorId,
      this.vendorName,
      this.vendorAddress,
      this.vendorPhone,
      this.vendorImage,
      this.restaurantCustomer,
      this.salesTotal,
      this.discount,
      this.total,
      this.isPaid,
      this.paymentMethod,
      this.paidBy,
      this.items,
      this.createdAt,
      this.updatedAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    vendorAddress = json['vendor_address'];
    vendorPhone = json['vendor_phone'];
    vendorImage = json['vendor_image'];
    restaurantCustomer = json['restaurant_customer'] != null
        ? new Customer.fromJson(json['restaurant_customer'])
        : null;
    salesTotal = json['sales_total'];
    discount = json['discount'];
    total = json['total'];
    isPaid = json['is_paid'];
    paymentMethod = json['payment_method'];
    paidBy = json['paid_by'];
    if (json['items'] != null) {
      items = <OrderItems>[];
      json['items'].forEach((v) {
        items!.add(new OrderItems.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['vendor_address'] = this.vendorAddress;
    data['vendor_phone'] = this.vendorPhone;
    data['vendor_image'] = this.vendorImage;
    if (this.restaurantCustomer != null) {
      data['restaurant_customer'] = this.restaurantCustomer!.toJson();
    }
    data['sales_total'] = this.salesTotal;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['is_paid'] = this.isPaid;
    data['payment_method'] = this.paymentMethod;
    data['paid_by'] = this.paidBy;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
