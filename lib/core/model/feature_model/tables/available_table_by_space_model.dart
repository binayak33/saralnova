import 'package:saralnova/core/model/feature_model/tables/table_model.dart';

List<AvailableTableBySpace> availableTablesBySpaceFromJson(
        List<dynamic> availablesTablesBySpacesJson) =>
    List<AvailableTableBySpace>.from(availablesTablesBySpacesJson.map(
        (availableTableBySpaceJson) =>
            AvailableTableBySpace.fromJson(availableTableBySpaceJson)));

class AvailableTableBySpace {
  String? spaceName;
  List<TableModel>? tables;

  AvailableTableBySpace({this.spaceName, this.tables});

  AvailableTableBySpace.fromJson(Map<String, dynamic> json) {
    spaceName = json['space_name'];
    if (json['tables'] != null) {
      tables = <TableModel>[];
      json['tables'].forEach((v) {
        tables!.add(new TableModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['space_name'] = this.spaceName;
    if (this.tables != null) {
      data['tables'] = this.tables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
