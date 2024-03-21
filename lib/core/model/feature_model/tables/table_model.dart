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
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['space_id'] = this.spaceId;
    data['space_name'] = this.spaceName;

    data['name'] = this.name;
    data['capacity'] = this.capacity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
