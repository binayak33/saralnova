List<KitchenOrderTicket> kitchenOrderTicketsFromJson(
        List<dynamic> kitchenOrderTicketsJson) =>
    List<KitchenOrderTicket>.from(
      kitchenOrderTicketsJson.map(
        (kitchenOrderTicket) => KitchenOrderTicket.fromJson(kitchenOrderTicket),
      ),
    );

// class KitchenOrderTicket {
//   String? id;
//   int? kotNumber;
//   String? vendorId;
//   String? vendorName;
//   String? vendorAddress;
//   String? vendorPhone;
//   String? vendorImage;
//   // Customer? restaurantCustomer;
//   String? billBy;
//   int? salesTotal;
//   int? discount;
//   int? total;
//   int? paidAmount;
//   int? remainingAmount;
//   int? advanceAmount;
//   TableModel? table;
//   bool? isPaid;
//   bool? isCancelled;
//   bool? isServed;
//   List<KotItems>? items;
//   String? createdAt;
//   String? updatedAt;

//   KitchenOrderTicket(
//       {this.id,
//       this.kotNumber,
//       this.vendorId,
//       this.vendorName,
//       this.vendorAddress,
//       this.vendorPhone,
//       this.vendorImage,
//       // this.restaurantCustomer,
//       this.billBy,
//       this.salesTotal,
//       this.discount,
//       this.total,
//       this.paidAmount,
//       this.remainingAmount,
//       this.advanceAmount,
//       this.table,
//       this.isPaid,
//       this.isServed,
//       this.isCancelled,
//       this.items,
//       this.createdAt,
//       this.updatedAt});

//   KitchenOrderTicket.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     kotNumber = json['kot_number'];
//     vendorId = json['vendor_id'];
//     vendorName = json['vendor_name'];
//     vendorAddress = json['vendor_address'];
//     vendorPhone = json['vendor_phone'];
//     vendorImage = json['vendor_image'];

//     // restaurantCustomer = json['restaurant_customer'] != null
//     //     ? Customer.fromJson(json['restaurant_customer'])
//     //     : null;

//     table = json['table'] != null ? TableModel.fromJson(json['table']) : null;
//     billBy = json['bill_by'];
//     salesTotal = json['sales_total'];
//     discount = json['discount'];
//     total = json['total'];
//     paidAmount = json['paid_amount'];
//     remainingAmount = json['remaining_amount'];
//     advanceAmount = json['advance_amount'];
//     isPaid = json['is_paid'];
//     isCancelled = json['is_cancelled'];
//     isServed = json['is_served'];
//     if (json['items'] != null) {
//       items = <KotItems>[];
//       json['items'].forEach((v) {
//         items!.add(new KotItems.fromJson(v));
//       });
//     }
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['kot_number'] = this.kotNumber;
//     data['vendor_id'] = this.vendorId;
//     data['vendor_name'] = this.vendorName;
//     data['vendor_address'] = this.vendorAddress;
//     data['vendor_phone'] = this.vendorPhone;
//     data['vendor_image'] = this.vendorImage;

//     // if (this.restaurantCustomer != null) {
//     //   data['restaurant_customer'] = this.restaurantCustomer!.toJson();
//     // }
//     if (this.table != null) {
//       data['table'] = this.table!.toJson();
//     }
//     data['bill_by'] = this.billBy;
//     data['sales_total'] = this.salesTotal;
//     data['discount'] = this.discount;
//     data['total'] = this.total;
//     data['paid_amount'] = this.paidAmount;
//     data['remaining_amount'] = this.remainingAmount;
//     data['advance_amount'] = this.advanceAmount;
//     data['is_paid'] = this.isPaid;
//     data['is_cancelled'] = this.isCancelled;
//     data['is_served'] = this.isServed;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// ==================optmized api
class KitchenOrderTicket {
  String? id;
  int? kotNumber;
  String? table;
  List<Items>? items;
  String? createdAt;

  KitchenOrderTicket(
      {this.id, this.kotNumber, this.table, this.items, this.createdAt});

  KitchenOrderTicket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kotNumber = json['kot_number'];
    table = json['table'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kot_number'] = this.kotNumber;
    data['table'] = this.table;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Items {
  String? id;
  String? menuTitle;
  int? quantity;
  bool? isPaid;
  bool? isCancelled;
  bool? isServed;
  String? menuImg;
  int? price;

  Items(
      {this.id,
      this.menuTitle,
      this.quantity,
      this.isPaid,
      this.isCancelled,
      this.menuImg,
      this.price,
      this.isServed});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuTitle = json['menu_title'];
    quantity = json['quantity'];
    isPaid = json['is_paid'];
    isCancelled = json['is_cancelled'];
    isServed = json['is_served'];
    menuImg = json['menu_image'];
    price = json['menu_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_title'] = this.menuTitle;
    data['quantity'] = this.quantity;
    data['is_paid'] = this.isPaid;
    data['is_cancelled'] = this.isCancelled;
    data['is_served'] = this.isServed;
    data['menu_image'] = this.menuImg;
    data['menu_price'] = this.price;

    return data;
  }
}
