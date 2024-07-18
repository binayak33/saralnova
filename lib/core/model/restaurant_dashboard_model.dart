class RestaurantDashboard {
  int? categoryCount;
  int? menuCount;
  int? tableCount;
  int? orderCount;
  int? newOrderCount;
  List<BestSellingMenus>? bestSellingMenus;

  RestaurantDashboard(
      {this.categoryCount,
      this.menuCount,
      this.tableCount,
      this.orderCount,
      this.newOrderCount,
      this.bestSellingMenus});

  RestaurantDashboard.fromJson(Map<String, dynamic> json) {
    categoryCount = json['categoryCount'];
    menuCount = json['menuCount'];
    tableCount = json['tableCount'];
    orderCount = json['orderCount'];
    newOrderCount = json['newOrderCount'];
    if (json['best_selling_menus'] != null) {
      bestSellingMenus = <BestSellingMenus>[];
      json['best_selling_menus'].forEach((v) {
        bestSellingMenus!.add(new BestSellingMenus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryCount'] = this.categoryCount;
    data['menuCount'] = this.menuCount;
    data['tableCount'] = this.tableCount;
    data['orderCount'] = this.orderCount;
    data['newOrderCount'] = this.newOrderCount;
    if (this.bestSellingMenus != null) {
      data['best_selling_menus'] =
          this.bestSellingMenus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BestSellingMenus {
  String? id;
  String? categoryId;
  String? vendorId;
  String? title;
  String? price;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? count;
  String? categoryName;
  String? imageUrl;

  BestSellingMenus(
      {this.id,
      this.categoryId,
      this.vendorId,
      this.title,
      this.price,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.count,
      this.categoryName,
      this.imageUrl});

  BestSellingMenus.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['category_id'].toString();
    vendorId = json['vendor_id'].toString();
    title = json['title'];
    price = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    count = json['count'];
    categoryName = json['category_name'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['count'] = this.count;
    data['category_name'] = this.categoryName;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
