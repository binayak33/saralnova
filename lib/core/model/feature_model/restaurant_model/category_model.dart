List<Category> restaurantCategoriesJson(List<dynamic> categoriesJson) =>
    List<Category>.from(
        categoriesJson.map((categoryJson) => Category.fromJson(categoryJson)));

class Category {
  String? id;
  String? title;
  String? vendorId;
  String? image;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id, this.title, this.vendorId, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vendorId = json['vendor_id'];
    image = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['vendor_id'] = this.vendorId;
    data['image_url'] = this.image;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
