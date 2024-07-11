import 'package:saralnova/core/model/feature_model/restaurant_model/variant_model.dart';

class PlaceOrderRequestModel {
  String? restaurantCustomerId;
  String? tableId;
  String? customerName;
  String? customerPhone;
  String? customerEmail;
  List<Items>? items;

  PlaceOrderRequestModel(
      {this.restaurantCustomerId,
      this.tableId,
      this.customerName,
      this.customerPhone,
      this.customerEmail,
      this.items});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_customer_id'] = this.restaurantCustomerId;
    data['table_id'] = this.tableId;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_email'] = this.customerEmail;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? menuId;
  int? quantity;
  List<Variant>? variants;

  Items({this.menuId, this.quantity, this.variants});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['quantity'] = this.quantity;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList() ?? [];
    }
    return data;
  }
}
