// To parse this JSON data, do
//
//     final saleProductModel = saleProductModelFromJson(jsonString);

import 'dart:convert';

class SaleProductModel {
  SaleProductModel({
    this.id,
    this.sale,
    this.product,
    this.amount,
    this.totalCost,
    this.totalCashback,
  });

  int? id;
  int? sale;
  int? product;
  int? amount;
  double? totalCost;
  double? totalCashback;

  factory SaleProductModel.fromRawJson(String str) =>
      SaleProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SaleProductModel.fromJson(Map<String, dynamic> json) =>
      SaleProductModel(
        id: json["id"] == null ? null : json["id"],
        sale: json["sale"] == null ? null : json["sale"],
        product: json["product"] == null ? null : json["product"],
        amount: json["amount"] == null ? null : json["amount"],
        totalCost: json["total_cost"] == null ? null : json["total_cost"],
        totalCashback: json["total_cashback"] == null
            ? null
            : json["total_cashback"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "sale": sale == null ? null : sale,
        "product": product == null ? null : product,
        "amount": amount == null ? null : amount,
        "total_cost": totalCost == null ? null : totalCost,
        "total_cashback": totalCashback == null ? null : totalCashback,
      };
}
