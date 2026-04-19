class PurchaseItemModel {
  final int spareId;
  final String spareName;
  final int quantity;
  final double unitCost;

  const PurchaseItemModel({
    required this.spareId,
    required this.spareName,
    required this.quantity,
    required this.unitCost,
  });

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    return PurchaseItemModel(
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitCost: (json['unitCost'] as num?)?.toDouble() ?? 0,
    );
  }
}

class PurchaseTransactionModel {
  final int id;
  final String createdAt;
  final double total;
  final List<PurchaseItemModel> items;

  const PurchaseTransactionModel({
    required this.id,
    required this.createdAt,
    required this.total,
    required this.items,
  });

  factory PurchaseTransactionModel.fromJson(Map<String, dynamic> json) {
    final itemsRaw = json['items'];
    return PurchaseTransactionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt']?.toString() ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0,
      items: itemsRaw is List
          ? itemsRaw
                .map(
                  (e) => PurchaseItemModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : const [],
    );
  }
}

class SaleItemModel {
  final int spareId;
  final String spareName;
  final int quantity;
  final double unitPrice;

  const SaleItemModel({
    required this.spareId,
    required this.spareName,
    required this.quantity,
    required this.unitPrice,
  });

  factory SaleItemModel.fromJson(Map<String, dynamic> json) {
    return SaleItemModel(
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0,
    );
  }
}

class SaleTransactionModel {
  final int id;
  final String createdAt;
  final double total;
  final int? appointmentId;
  final List<SaleItemModel> items;

  const SaleTransactionModel({
    required this.id,
    required this.createdAt,
    required this.total,
    required this.appointmentId,
    required this.items,
  });

  factory SaleTransactionModel.fromJson(Map<String, dynamic> json) {
    final itemsRaw = json['items'];
    return SaleTransactionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt']?.toString() ?? '',
      total: (json['total'] as num?)?.toDouble() ?? 0,
      appointmentId: (json['appointmentId'] as num?)?.toInt(),
      items: itemsRaw is List
          ? itemsRaw
                .map((e) => SaleItemModel.fromJson(e as Map<String, dynamic>))
                .toList()
          : const [],
    );
  }
}

class DailySalesSummaryModel {
  final String date;
  final int totalTransactions;
  final double totalAmount;

  const DailySalesSummaryModel({
    required this.date,
    required this.totalTransactions,
    required this.totalAmount,
  });

  factory DailySalesSummaryModel.fromJson(Map<String, dynamic> json) {
    return DailySalesSummaryModel(
      date: json['date']?.toString() ?? '',
      totalTransactions: (json['totalTransactions'] as num?)?.toInt() ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
    );
  }
}
