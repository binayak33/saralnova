import 'package:saralnova/core/model/feature_model/tables/table_model.dart';

List<MergeTable> mergeTablesFromJson(List<dynamic> mergetablesJson) =>
    List<MergeTable>.from(mergetablesJson
        .map((mergeTableJson) => MergeTable.fromJson(mergeTableJson)));

class MergeTable {
  String? mergeName;
  String? tableId;
  MainTable? mainTable;
  List<TableModel>? tables;

  MergeTable({this.mergeName, this.tableId, this.mainTable, this.tables});

  MergeTable.fromJson(Map<String, dynamic> json) {
    mergeName = json['merge_name'];
    tableId = json['table_id'].toString();
    mainTable = json['main_table'] != null
        ? new MainTable.fromJson(json['main_table'])
        : null;
    if (json['tables'] != null) {
      tables = <TableModel>[];
      json['tables'].forEach((v) {
        tables!.add(new TableModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merge_name'] = this.mergeName;
    data['table_id'] = this.tableId;
    if (this.mainTable != null) {
      data['main_table'] = this.mainTable!.toJson();
    }
    if (this.tables != null) {
      data['tables'] = this.tables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainTable {
  String? id;
  String? vendorId;
  String? spaceId;
  String? name;
  int? capacity;
  String? status;
  String? createdAt;
  String? updatedAt;

  MainTable(
      {this.id,
      this.vendorId,
      this.spaceId,
      this.name,
      this.capacity,
      this.status,
      this.createdAt,
      this.updatedAt});

  MainTable.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    vendorId = json['vendor_id'].toString();
    spaceId = json['space_id'].toString();
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
    data['name'] = this.name;
    data['capacity'] = this.capacity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
