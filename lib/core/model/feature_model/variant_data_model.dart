class VariantData {
  String? variantId;
  int? quantity;
  String? title;
  int? price;
  String? type;

  VariantData(
      {this.variantId, this.quantity, this.title, this.price, this.type});

  VariantData.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    quantity = json['quantity'];
    title = json['title'];
    price = json['price'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    data['quantity'] = this.quantity;
    data['title'] = this.title;
    data['price'] = this.price;
    data['type'] = this.type;
    return data;
  }
}
