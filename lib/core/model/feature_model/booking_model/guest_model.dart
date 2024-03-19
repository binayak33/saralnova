class Guest {
  String? id;
  String? vendorId;
  String? name;
  String? contact;
  String? email;
  String? address;
  String? nationality;
  String? citizenship;
  String? passport;
  String? purposeOfVisit;
  String? documentType;
  String? documentNumber;
  String? frequentGuestPoints;
  String? createdAt;
  String? updatedAt;

  Guest(
      {this.id,
      this.vendorId,
      this.name,
      this.contact,
      this.email,
      this.address,
      this.nationality,
      this.citizenship,
      this.passport,
      this.purposeOfVisit,
      this.documentType,
      this.documentNumber,
      this.frequentGuestPoints,
      this.createdAt,
      this.updatedAt});

  Guest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    vendorId = json['vendor_id'].toString();
    name = json['name'];
    contact = json['contact'];
    email = json['email'];
    address = json['address'];
    nationality = json['nationality'];
    citizenship = json['citizenship'];
    passport = json['passport'];
    purposeOfVisit = json['purpose_of_visit'];
    documentType = json['document_type'];
    documentNumber = json['document_number'];
    frequentGuestPoints = json['frequent_guest_points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['address'] = this.address;
    data['nationality'] = this.nationality;
    data['citizenship'] = this.citizenship;
    data['passport'] = this.passport;
    data['purpose_of_visit'] = this.purposeOfVisit;
    data['document_type'] = this.documentType;
    data['document_number'] = this.documentNumber;
    data['frequent_guest_points'] = this.frequentGuestPoints;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
