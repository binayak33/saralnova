class Payments {
  int? totalAmount;
  int? discount;
  int? advanceAmount;
  int? paidAmount;
  int? remainingAmount;
  int? subtotal;

  Payments(
      {this.totalAmount,
      this.discount,
      this.advanceAmount,
      this.paidAmount,
      this.remainingAmount,
      this.subtotal});

  Payments.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    discount = json['discount'];
    advanceAmount = json['advance_amount'];
    paidAmount = json['paid_amount'];
    remainingAmount = json['remaining_amount'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['advance_amount'] = this.advanceAmount;
    data['paid_amount'] = this.paidAmount;
    data['remaining_amount'] = this.remainingAmount;
    data['subtotal'] = this.subtotal;
    return data;
  }
}