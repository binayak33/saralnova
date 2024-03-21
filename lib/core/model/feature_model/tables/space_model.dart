List<Space> tableSpaceJson(List<dynamic> spacesJson) =>
    List<Space>.from(spacesJson.map((spaceJson) => Space.fromJson(spaceJson)));

class Space {
  String? id;
  String? vendorId;
  String? name;
  String? description;
  num? tableCount;
  String? createdAt;
  String? updatedAt;

  Space(
      {this.id,
      this.vendorId,
      this.name,
      this.description,
      this.createdAt,
      this.tableCount,
      this.updatedAt});

  Space.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    description = json['description'];
    tableCount = json['table_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    if (id != null) data['id'] = this.id;

    // data['vendor_id'] = this.vendorId;
    if (vendorId != null) data['vendor_id'] = this.vendorId;
    // data['name'] = this.name;
    if (name != null) data['name'] = this.name;
    // data['description'] = this.description;
    if (description != null) data['description'] = this.description;
    // data['table_count'] = this.tableCount;
    if (tableCount != null) data['table_count'] = this.tableCount;

    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}
