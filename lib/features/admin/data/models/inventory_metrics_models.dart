class TopSellingSpareMetric {
  final int spareId;
  final String spareName;
  final String savCode;
  final int unitsSold;

  const TopSellingSpareMetric({
    required this.spareId,
    required this.spareName,
    required this.savCode,
    required this.unitsSold,
  });

  int get totalUnitsSold => unitsSold;

  factory TopSellingSpareMetric.fromJson(Map<String, dynamic> json) {
    return TopSellingSpareMetric(
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      savCode: json['savCode']?.toString() ?? '',
      unitsSold:
          (json['unitsSold'] as num?)?.toInt() ??
          (json['totalUnitsSold'] as num?)?.toInt() ??
          0,
    );
  }
}

class InventoryProfitMetric {
  final String startDate;
  final String endDate;
  final int totalUnitsSold;
  final double grossSalesAmount;
  final double estimatedProfitAmount;

  const InventoryProfitMetric({
    required this.startDate,
    required this.endDate,
    required this.totalUnitsSold,
    required this.grossSalesAmount,
    required this.estimatedProfitAmount,
  });

  double get grossSales => grossSalesAmount;
  double get estimatedProfit => estimatedProfitAmount;

  factory InventoryProfitMetric.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return InventoryProfitMetric(
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      totalUnitsSold: (json['totalUnitsSold'] as num?)?.toInt() ?? 0,
      grossSalesAmount: parseDouble(
        json['grossSalesAmount'] ?? json['grossSales'],
      ),
      estimatedProfitAmount: parseDouble(
        json['estimatedProfitAmount'] ?? json['estimatedProfit'],
      ),
    );
  }
}

class StagnantSpareMetric {
  final int spareId;
  final String spareName;
  final String savCode;
  final int currentStock;
  final String? lastSaleDate;
  final int? daysWithoutSales;
  final bool neverSold;

  const StagnantSpareMetric({
    required this.spareId,
    required this.spareName,
    required this.savCode,
    required this.currentStock,
    required this.lastSaleDate,
    required this.daysWithoutSales,
    required this.neverSold,
  });

  factory StagnantSpareMetric.fromJson(Map<String, dynamic> json) {
    final rawLastSaleDate = json['lastSaleDate']?.toString();
    return StagnantSpareMetric(
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      savCode: json['savCode']?.toString() ?? '',
      currentStock: (json['currentStock'] as num?)?.toInt() ?? 0,
      lastSaleDate: rawLastSaleDate == null || rawLastSaleDate.isEmpty
          ? null
          : rawLastSaleDate,
      daysWithoutSales: (json['daysWithoutSales'] as num?)?.toInt(),
      neverSold: json['neverSold'] == true,
    );
  }
}

class BelowThresholdPercentageMetric {
  final int sparesBelowThreshold;
  final int sparesWithThreshold;
  final double belowThresholdPercent;

  const BelowThresholdPercentageMetric({
    required this.sparesBelowThreshold,
    required this.sparesWithThreshold,
    required this.belowThresholdPercent,
  });

  int get totalWithThreshold => sparesWithThreshold;
  int get belowThresholdCount => sparesBelowThreshold;
  double get percentage => belowThresholdPercent;

  factory BelowThresholdPercentageMetric.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return BelowThresholdPercentageMetric(
      sparesBelowThreshold:
          (json['sparesBelowThreshold'] as num?)?.toInt() ??
          (json['belowThresholdCount'] as num?)?.toInt() ??
          0,
      sparesWithThreshold:
          (json['sparesWithThreshold'] as num?)?.toInt() ??
          (json['totalWithThreshold'] as num?)?.toInt() ??
          0,
      belowThresholdPercent: parseDouble(
        json['belowThresholdPercent'] ?? json['percentage'],
      ),
    );
  }
}
