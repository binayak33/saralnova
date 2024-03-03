List<Staff> staffFromJson(List<dynamic> staffsJson) =>
    List<Staff>.from(staffsJson.map((staffJson) => Staff.fromJson(staffJson)));

class Staff {
  String? id;
  String? name;
  String? email;
  String? username;

  Staff({this.id, this.name, this.email, this.username});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    return data;
  }
}
