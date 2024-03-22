List<MenuVariant> menuVariantsJson(List<dynamic> menuVariantsJson) =>
    List<MenuVariant>.from(menuVariantsJson
        .map((menuVariantJson) => MenuVariant.fromJson(menuVariantJson)));

class MenuVariant {
  String? id;
  String? vendorId;
  String? title;
  int? price;
  String? type;
  String? description;
  String? menuId;
  int? minQty;
  int? maxQty;
  String? createdAt;
  String? updatedAt;

  MenuVariant(
      {this.id,
      this.vendorId,
      this.title,
      this.price,
      this.type,
      this.description,
      this.menuId,
      this.minQty,
      this.maxQty,
      this.createdAt,
      this.updatedAt});

  MenuVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    price = json['price'];
    type = json['type'];
    description = json['description'];
    menuId = json['menu_id'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['type'] = this.type;
    data['description'] = this.description;
    data['menu_id'] = this.menuId;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
