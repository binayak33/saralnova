List<TableModel> tablesJson(List<dynamic> tablesJson) => List<TableModel>.from(
    tablesJson.map((tableJson) => TableModel.fromJson(tableJson)));

class TableModel {
  String? id;
  String? vendorId;
  String? spaceId;
  String? spaceName;
  String? name;
  int? capacity;
  String? status;
  String? createdAt;
  String? updatedAt;

  TableModel(
      {this.id,
      this.vendorId,
      this.spaceId,
      this.spaceName,
      this.name,
      this.capacity,
      this.status,
      this.createdAt,
      this.updatedAt});

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    spaceId = json['space_id'];
    spaceName = json['space_name'];
    name = json['name'];
    capacity = json['capacity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    if (id != null) data['id'] = this.id;
    if (vendorId != null) data['vendor_id'] = this.vendorId;
    if (spaceId != null) data['space_id'] = this.spaceId;
    if (spaceName != null) data['space_name'] = this.spaceName;

    if (name != null) data['name'] = this.name;
    if (capacity != null) data['capacity'] = this.capacity;
    if (status != null) data['status'] = this.status;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}
