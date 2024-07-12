List<PendingOrders> pendingKOTordersFromJson(List<dynamic> pendingKOTsJson) =>
    List<PendingOrders>.from(
      pendingKOTsJson.map(
        (pendingKOT) => PendingOrders.fromJson(pendingKOT),
      ),
    );

class PendingOrders {
  String? id;
  int? kotNumber;
  String? table;
  List<Items>? items;
  String? createdAt;

  PendingOrders(
      {this.id, this.kotNumber, this.table, this.items, this.createdAt});

  PendingOrders.fromJson(Map<String, dynamic> json) {
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

  Items(
      {this.id,
      this.menuTitle,
      this.quantity,
      this.isPaid,
      this.isCancelled,
      this.isServed});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuTitle = json['menu_title'];
    quantity = json['quantity'];
    isPaid = json['is_paid'];
    isCancelled = json['is_cancelled'];
    isServed = json['is_served'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_title'] = this.menuTitle;
    data['quantity'] = this.quantity;
    data['is_paid'] = this.isPaid;
    data['is_cancelled'] = this.isCancelled;
    data['is_served'] = this.isServed;
    return data;
  }
}
