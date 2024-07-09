import 'package:saralnova/core/model/feature_model/variant_data_model.dart';

class OrderItems {
  String? id;
  String? orderId;
  String? menuId;
  String? menuTitle;
  int? menuPrice;
  List<VariantData>? variantData;
  int? quantity;
  String? image;
  int? total;
  String? createdAt;
  String? updatedAt;

  OrderItems(
      {this.id,
      this.orderId,
      this.menuId,
      this.menuTitle,
      this.menuPrice,
      this.variantData,
      this.quantity,
      this.image,
      this.total,
      this.createdAt,
      this.updatedAt});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    menuId = json['menu_id'];
    menuTitle = json['menu_title'];
    menuPrice = json['menu_price'];
    if (json['variant_data'] != null) {
      variantData = <VariantData>[];
      json['variant_data'].forEach((v) {
        variantData!.add(new VariantData.fromJson(v));
      });
    }
    quantity = json['quantity'];
    total = json['total'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['menu_id'] = this.menuId;
    data['menu_title'] = this.menuTitle;
    data['menu_price'] = this.menuPrice;
    if (this.variantData != null) {
      data['variant_data'] = this.variantData!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['image'] = this.image;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
