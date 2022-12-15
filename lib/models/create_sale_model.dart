// To parse this JSON data, do
//
//     final createSaleModel = createSaleModelFromJson(jsonString);

import 'dart:convert';

class CreateSaleModel {
  CreateSaleModel({
    this.id,
    this.branch,
    this.client,
    this.productSale,
    this.finalCost,
    this.finalCashback,
    this.fromBalanceAmount,
    this.sold,
    this.datetime,
  });

  int? id;
  int? branch;
  int? client;
  List<dynamic>? productSale;
  int? finalCost;
  int? finalCashback;
  String? fromBalanceAmount;
  bool? sold;
  DateTime? datetime;

  factory CreateSaleModel.fromRawJson(String str) =>
      CreateSaleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateSaleModel.fromJson(Map<String, dynamic> json) =>
      CreateSaleModel(
        id: json["id"] == null ? null : json["id"],
        branch: json["branch"] == null ? null : json["branch"],
        client: json["client"] == null ? null : json["client"],
        productSale: json["product_sale"] == null
            ? null
            : List<dynamic>.from(json["product_sale"].map((x) => x)),
        finalCost: json["final_cost"] == null ? null : json["final_cost"],
        finalCashback:
            json["final_cashback"] == null ? null : json["final_cashback"],
        fromBalanceAmount: json["from_balance_amount"] == null
            ? null
            : json["from_balance_amount"],
        sold: json["sold"] == null ? null : json["sold"],
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branch": branch == null ? null : branch,
        "client": client == null ? null : client,
        "product_sale": productSale == null
            ? null
            : List<dynamic>.from(productSale!.map((x) => x)),
        "final_cost": finalCost == null ? null : finalCost,
        "final_cashback": finalCashback == null ? null : finalCashback,
        "from_balance_amount":
            fromBalanceAmount == null ? null : fromBalanceAmount,
        "sold": sold == null ? null : sold,
        "datetime": datetime == null ? null : datetime!.toIso8601String(),
      };
}
