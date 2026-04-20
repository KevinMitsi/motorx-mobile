class PurchaseItemModel {
  final int id;
  final int spareId;
  final String spareName;
  final int quantity;
  final double purchasePriceWithVat;
  final double lineTotal;

  const PurchaseItemModel({
    required this.id,
    required this.spareId,
    required this.spareName,
    required this.quantity,
    required this.purchasePriceWithVat,
    required this.lineTotal,
  });

  double get unitCost => purchasePriceWithVat;

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return PurchaseItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      purchasePriceWithVat: parseDouble(
        json['purchasePriceWithVat'] ?? json['unitCost'],
      ),
      lineTotal: parseDouble(json['lineTotal']),
    );
  }
}

class PurchaseTransactionModel {
  final int id;
  final String supplier;
  final String transactionDate;
  final int createdByUserId;
  final String createdByEmail;
  final double totalAmount;
  final List<PurchaseItemModel> items;

  const PurchaseTransactionModel({
    required this.id,
    required this.supplier,
    required this.transactionDate,
    required this.createdByUserId,
    required this.createdByEmail,
    required this.totalAmount,
    required this.items,
  });

  String get createdAt => transactionDate;
  double get total => totalAmount;

  factory PurchaseTransactionModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    final itemsRaw = json['items'];
    return PurchaseTransactionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      supplier: json['supplier']?.toString() ?? '',
      transactionDate:
          json['transactionDate']?.toString() ??
          json['createdAt']?.toString() ??
          '',
      createdByUserId: (json['createdByUserId'] as num?)?.toInt() ?? 0,
      createdByEmail: json['createdByEmail']?.toString() ?? '',
      totalAmount: parseDouble(json['totalAmount'] ?? json['total']),
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
  final int id;
  final int spareId;
  final String spareName;
  final int quantity;
  final double salePriceAtMoment;
  final double lineTotal;

  const SaleItemModel({
    required this.id,
    required this.spareId,
    required this.spareName,
    required this.quantity,
    required this.salePriceAtMoment,
    required this.lineTotal,
  });

  double get unitPrice => salePriceAtMoment;

  factory SaleItemModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return SaleItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      salePriceAtMoment: parseDouble(
        json['salePriceAtMoment'] ?? json['unitPrice'],
      ),
      lineTotal: parseDouble(json['lineTotal']),
    );
  }
}

class SaleTransactionModel {
  final int id;
  final String transactionDate;
  final int? appointmentId;
  final int createdByUserId;
  final String createdByEmail;
  final double totalAmount;
  final List<SaleItemModel> items;

  const SaleTransactionModel({
    required this.id,
    required this.transactionDate,
    required this.appointmentId,
    required this.createdByUserId,
    required this.createdByEmail,
    required this.totalAmount,
    required this.items,
  });

  String get createdAt => transactionDate;
  double get total => totalAmount;

  factory SaleTransactionModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    final itemsRaw = json['items'];
    return SaleTransactionModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      transactionDate:
          json['transactionDate']?.toString() ??
          json['createdAt']?.toString() ??
          '',
      appointmentId: (json['appointmentId'] as num?)?.toInt(),
      createdByUserId: (json['createdByUserId'] as num?)?.toInt() ?? 0,
      createdByEmail: json['createdByEmail']?.toString() ?? '',
      totalAmount: parseDouble(json['totalAmount'] ?? json['total']),
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
  final double totalSales;
  final int transactionCount;
  final List<SaleTransactionModel> sales;

  const DailySalesSummaryModel({
    required this.date,
    required this.totalSales,
    required this.transactionCount,
    required this.sales,
  });

  int get totalTransactions => transactionCount;
  double get totalAmount => totalSales;

  factory DailySalesSummaryModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    final salesRaw = json['sales'];
    return DailySalesSummaryModel(
      date: json['date']?.toString() ?? '',
      totalSales: parseDouble(json['totalSales'] ?? json['totalAmount']),
      transactionCount:
          (json['transactionCount'] as num?)?.toInt() ??
          (json['totalTransactions'] as num?)?.toInt() ??
          0,
      sales: salesRaw is List
          ? salesRaw
                .map(
                  (e) =>
                      SaleTransactionModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : const [],
    );
  }
}
