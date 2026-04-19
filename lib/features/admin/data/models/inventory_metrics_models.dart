class TopSellingSpareMetric {
  final int spareId;
  final String spareName;
  final String savCode;
  final int totalUnitsSold;

  const TopSellingSpareMetric({
    required this.spareId,
    required this.spareName,
    required this.savCode,
    required this.totalUnitsSold,
  });

  factory TopSellingSpareMetric.fromJson(Map<String, dynamic> json) {
    return TopSellingSpareMetric(
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      savCode: json['savCode']?.toString() ?? '',
      totalUnitsSold: (json['totalUnitsSold'] as num?)?.toInt() ?? 0,
    );
  }
}

class InventoryProfitMetric {
  final String startDate;
  final String endDate;
  final double grossSales;
  final double estimatedProfit;

  const InventoryProfitMetric({
    required this.startDate,
    required this.endDate,
    required this.grossSales,
    required this.estimatedProfit,
  });

  factory InventoryProfitMetric.fromJson(Map<String, dynamic> json) {
    return InventoryProfitMetric(
      startDate: json['startDate']?.toString() ?? '',
      endDate: json['endDate']?.toString() ?? '',
      grossSales: (json['grossSales'] as num?)?.toDouble() ?? 0,
      estimatedProfit: (json['estimatedProfit'] as num?)?.toDouble() ?? 0,
    );
  }
}

class StagnantSpareMetric {
  final int spareId;
  final String spareName;
  final String savCode;
  final int? daysWithoutSales;

  const StagnantSpareMetric({
    required this.spareId,
    required this.spareName,
    required this.savCode,
    required this.daysWithoutSales,
  });

  factory StagnantSpareMetric.fromJson(Map<String, dynamic> json) {
    return StagnantSpareMetric(
      spareId: (json['spareId'] as num?)?.toInt() ?? 0,
      spareName: json['spareName']?.toString() ?? '',
      savCode: json['savCode']?.toString() ?? '',
      daysWithoutSales: (json['daysWithoutSales'] as num?)?.toInt(),
    );
  }
}

class BelowThresholdPercentageMetric {
  final int totalWithThreshold;
  final int belowThresholdCount;
  final double percentage;

  const BelowThresholdPercentageMetric({
    required this.totalWithThreshold,
    required this.belowThresholdCount,
    required this.percentage,
  });

  factory BelowThresholdPercentageMetric.fromJson(Map<String, dynamic> json) {
    return BelowThresholdPercentageMetric(
      totalWithThreshold: (json['totalWithThreshold'] as num?)?.toInt() ?? 0,
      belowThresholdCount: (json['belowThresholdCount'] as num?)?.toInt() ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0,
    );
  }
}
