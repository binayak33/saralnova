import 'package:saralnova/core/model/feature_model/tables/table_model.dart';

List<Customer> customersFromJson(List<dynamic> customersJson) =>
    List<Customer>.from(
        customersJson.map((customerJson) => Customer.fromJson(customerJson)));

class Customer {
  String? id;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  bool? isPaid;
  int? kotCount;
  num? total;
  List<TableModel>? tables;
  String? createdAt;

  String? updatedAt;

  Customer(
      {this.id,
      this.customerName,
      this.customerPhone,
      this.customerEmail,
      this.isPaid,
      this.kotCount,
      this.total,
      this.tables,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerEmail = json['customer_email'];
    isPaid = json['is_paid'];
    kotCount = json['kot_count'];
    total = json['total'];
    if (json['table'] != null) {
      tables = <TableModel>[];
      json['table'].forEach((v) {
        tables!.add(new TableModel.fromJson(v));
      });
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_email'] = this.customerEmail;
    data['is_paid'] = this.isPaid;
    data['kot_count'] = this.kotCount;
    data['total'] = this.total;
    if (this.tables != null) {
      data['table'] = this.tables!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
