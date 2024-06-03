class BillModel {
  String? id;
  String? name;
  int? quantyti;
  double? price;
  bool? isCheckVip;
  double? total;
  BillModel(
      {this.id,
      this.name,
      this.quantyti,
      this.price,
      this.isCheckVip,
      this.total});
  double get totalBill => (price ?? 0.0) * (quantyti ?? 0);
  BillModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantyti = json['quantyti'];
    price = json['price'];
    isCheckVip = json['isCheckVip'];
    total = json['total'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantyti': quantyti,
      'price': price,
      'isCheckVip': isCheckVip,
      'total': total
    };
  }
}

List<BillModel> listBill = [
  BillModel(
      id: '1',
      name: 'Nguyễn Văn Tâm',
      quantyti: 2,
      price: 100,
      isCheckVip: true,
      total: 200),
];
