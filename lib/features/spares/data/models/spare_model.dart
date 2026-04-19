class SpareModel {
  final int id;
  final String name;
  final String savCode;
  final String spareCode;
  final int quantity;
  final double purchasePriceWithVat;
  final double salePrice;
  final bool isOil;
  final String warehouseLocation;
  final int stockThreshold;

  const SpareModel({
    required this.id,
    required this.name,
    required this.savCode,
    required this.spareCode,
    required this.quantity,
    required this.purchasePriceWithVat,
    required this.salePrice,
    required this.isOil,
    required this.warehouseLocation,
    required this.stockThreshold,
  });

  factory SpareModel.fromJson(Map<String, dynamic> json) {
    double parseDouble(dynamic value) {
      if (value is num) return value.toDouble();
      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return SpareModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      savCode: json['savCode']?.toString() ?? '',
      spareCode: json['spareCode']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      purchasePriceWithVat: parseDouble(json['purchasePriceWithVat']),
      salePrice: parseDouble(json['salePrice']),
      isOil: json['isOil'] == true,
      warehouseLocation: json['warehouseLocation']?.toString() ?? '',
      stockThreshold: (json['stockThreshold'] as num?)?.toInt() ?? 0,
    );
  }
}
