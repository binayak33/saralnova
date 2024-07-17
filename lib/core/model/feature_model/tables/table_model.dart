import 'package:saralnova/core/model/feature_model/tables/space_model.dart';

List<TableModel> tablesJson(List<dynamic> tablesJson) => List<TableModel>.from(
    tablesJson.map((tableJson) => TableModel.fromJson(tableJson)));

class TableModel {
  String? id;
  String? vendorId;

  Space? space;
  String? name;
  int? capacity;
  String? status;
  String? createdAt;
  String? updatedAt;

  TableModel(
      {this.id,
      this.vendorId,
      this.space,
      this.name,
      this.capacity,
      this.status,
      this.createdAt,
      this.updatedAt});

  TableModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    vendorId = json['vendor_id'].toString();

    name = json['name'];
    capacity = json['capacity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    space = json['space'] != null ? new Space.fromJson(json['space']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (id != null) data['id'] = this.id;
    if (vendorId != null) data['vendor_id'] = this.vendorId;

    if (name != null) data['name'] = this.name;
    if (capacity != null) data['capacity'] = this.capacity;
    if (status != null) data['status'] = this.status;

    if (this.space != null) {
      data['space'] = this.space!.toJson();
    }
    return data;
  }
}
