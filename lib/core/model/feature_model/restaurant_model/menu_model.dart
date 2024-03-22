import 'package:saralnova/core/model/feature_model/restaurant_model/menu_variant_model.dart';

List<Menu> menusRestaurantJson(List<dynamic> menusJson) =>
    List<Menu>.from(menusJson.map((menuJson) => Menu.fromJson(menuJson)));

class Menu {
  String? id;
  String? vendorId;
  String? title;
  int? price;
  String? categoryId;
  String? categoryTitle;
  List<MenuVariant>? menuVariants;
  String? imageUrl;
  String? description;
  String? createdAt;
  String? updatedAt;

  Menu(
      {this.id,
      this.vendorId,
      this.title,
      this.price,
      this.categoryId,
      this.categoryTitle,
      this.menuVariants,
      this.imageUrl,
      this.description,
      this.createdAt,
      this.updatedAt});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    price = json['price'];
    categoryId = json['category_id'];
    categoryTitle = json['category_title'];
    if (json['menu_variants'] != null) {
      menuVariants = <MenuVariant>[];
      json['menu_variants'].forEach((v) {
        menuVariants!.add(new MenuVariant.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['category_title'] = this.categoryTitle;
    if (this.menuVariants != null) {
      data['menu_variants'] =
          this.menuVariants!.map((v) => v.toJson()).toList();
    }
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
