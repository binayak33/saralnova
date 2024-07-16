List<PaymentMethod> peymentMethodFromJson(List<dynamic> paymentsJson) =>
    List<PaymentMethod>.from(
        paymentsJson.map((paymentJson) => PaymentMethod.fromJson(paymentJson)));

class PaymentMethod {
  String? id;
  String? title;
  String? vendorId;
  String? image;

  PaymentMethod({this.id, this.title, this.vendorId, this.image});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    vendorId = json['vendor_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['vendor_id'] = this.vendorId;
    data['image'] = this.image;
    return data;
  }
}
