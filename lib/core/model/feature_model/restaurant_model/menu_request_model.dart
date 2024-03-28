import 'dart:convert';

class MenuRequestParams {
  String? title;
  int? price;
  String? categoryId;
  String? description;
  // File? menuImage;
  List<Variants>? variants;

  MenuRequestParams(
      {this.title,
      this.price,
      this.categoryId,
      this.description,
      // this.menuImage,
      this.variants});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    // data['image'] = this.menuImage.toString();
    // if (this.variants != null) {
    //   data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    // }
    data['variants'] =
        json.encode(variants?.map((v) => v.toJson()).toList() ?? []);

    return data;
  }
}

class Variants {
  String? id;
  int? price;
  int? minQty;
  int? maxQty;

  Variants({this.id, this.price, this.minQty, this.maxQty});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['price'] = this.price;
    data['min_qty'] = this.minQty;
    data['max_qty'] = this.maxQty;
    return data;
  }
}
