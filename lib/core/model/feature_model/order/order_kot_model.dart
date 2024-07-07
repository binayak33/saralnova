import '../tables/table_model.dart';

List<KitchenOrderTicket> kitchenOrderTicketsFromJson(
        List<dynamic> kitchenOrderTicketsJson) =>
    List<KitchenOrderTicket>.from(
      kitchenOrderTicketsJson.map(
        (kitchenOrderTicket) => KitchenOrderTicket.fromJson(kitchenOrderTicket),
      ),
    );

class KitchenOrderTicket {
  String? id;
  int? kotNumber;
  String? vendorId;
  String? vendorName;
  String? vendorAddress;
  String? vendorPhone;
  String? vendorImage;
  // Customer? restaurantCustomer;
  String? billBy;
  int? salesTotal;
  int? discount;
  int? total;
  int? paidAmount;
  int? remainingAmount;
  int? advanceAmount;
  TableModel? table;
  bool? isPaid;
  bool? isCancelled;
  bool? isServed;
  List<Items>? items;
  String? createdAt;
  String? updatedAt;

  KitchenOrderTicket(
      {this.id,
      this.kotNumber,
      this.vendorId,
      this.vendorName,
      this.vendorAddress,
      this.vendorPhone,
      this.vendorImage,
      // this.restaurantCustomer,
      this.billBy,
      this.salesTotal,
      this.discount,
      this.total,
      this.paidAmount,
      this.remainingAmount,
      this.advanceAmount,
      this.table,
      this.isPaid,
      this.isServed,
      this.isCancelled,
      this.items,
      this.createdAt,
      this.updatedAt});

  KitchenOrderTicket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kotNumber = json['kot_number'];
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    vendorAddress = json['vendor_address'];
    vendorPhone = json['vendor_phone'];
    vendorImage = json['vendor_image'];

    // restaurantCustomer = json['restaurant_customer'] != null
    //     ? Customer.fromJson(json['restaurant_customer'])
    //     : null;

    table = json['table'] != null ? TableModel.fromJson(json['table']) : null;
    billBy = json['bill_by'];
    salesTotal = json['sales_total'];
    discount = json['discount'];
    total = json['total'];
    paidAmount = json['paid_amount'];
    remainingAmount = json['remaining_amount'];
    advanceAmount = json['advance_amount'];
    isPaid = json['is_paid'];
    isCancelled = json['is_cancelled'];
    isServed = json['is_served'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kot_number'] = this.kotNumber;
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['vendor_address'] = this.vendorAddress;
    data['vendor_phone'] = this.vendorPhone;
    data['vendor_image'] = this.vendorImage;

    // if (this.restaurantCustomer != null) {
    //   data['restaurant_customer'] = this.restaurantCustomer!.toJson();
    // }
    if (this.table != null) {
      data['table'] = this.table!.toJson();
    }
    data['bill_by'] = this.billBy;
    data['sales_total'] = this.salesTotal;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['paid_amount'] = this.paidAmount;
    data['remaining_amount'] = this.remainingAmount;
    data['advance_amount'] = this.advanceAmount;
    data['is_paid'] = this.isPaid;
    data['is_cancelled'] = this.isCancelled;
    data['is_served'] = this.isServed;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Items {
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

  Items(
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

  Items.fromJson(Map<String, dynamic> json) {
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
