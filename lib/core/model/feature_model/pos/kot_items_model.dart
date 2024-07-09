import 'package:saralnova/core/model/feature_model/variant_data_model.dart';

class KotItems {
  String? id;
  String? kotId;
  String? menuId;
  String? menuTitle;
  int? menuPrice;
  List<VariantData>? variantData;
  int? quantity;
  int? total;
  bool? isPaid;
  bool? isCancelled;
  bool? isServed;
  String? createdAt;
  String? updatedAt;

  KotItems(
      {this.id,
      this.kotId,
      this.menuId,
      this.menuTitle,
      this.menuPrice,
      this.variantData,
      this.quantity,
      this.total,
      this.isPaid,
      this.isCancelled,
      this.isServed,
      this.createdAt,
      this.updatedAt});

  KotItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kotId = json['kot_id'];
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
    isPaid = json['is_paid'];
    isServed = json['is_served'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kot_id'] = this.kotId;
    data['menu_id'] = this.menuId;
    data['menu_title'] = this.menuTitle;
    data['menu_price'] = this.menuPrice;
    if (this.variantData != null) {
      data['variant_data'] = this.variantData!.map((v) => v.toJson()).toList();
    }
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['is_paid'] = this.isPaid;
    data['is_served'] = this.isServed;

    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
