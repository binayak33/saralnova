class MenuRequestParams {
  String? id;
  String? title;
  int? price;
  String? categoryId;
  String? description;
  // File? menuImage;
  List<Variants>? variants;

  MenuRequestParams(
      {this.id,
      this.title,
      this.price,
      this.categoryId,
      this.description,
      // this.menuImage,
      this.variants});

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['id'] = this.id.toString();

    data['title'] = this.title.toString();
    data['price'] = this.price.toString();
    data['category_id'] = this.categoryId.toString();
    data['description'] = this.description.toString();
    // data['image'] = this.menuImage.toString();
    if (this.variants != null) {
      data['variants'] =
          this.variants!.map((v) => v.toJson()).toList().toString();
    }
    // data['variants'] =
    //     json.encode(variants?.map((v) => v.toJson()).toList() ?? []);

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
