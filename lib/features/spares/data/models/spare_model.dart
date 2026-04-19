class SpareModel {
  final int id;
  final String name;
  final String savCode;
  final String spareCode;
  final String supplier;
  final List<String> compatibleMotorcycles;
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
    required this.supplier,
    required this.compatibleMotorcycles,
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

    List<String> parseCompatibleMotorcycles(dynamic value) {
      if (value is List) {
        return value
            .map((e) => e.toString())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      if (value is String && value.trim().isNotEmpty) {
        return [value.trim()];
      }
      return const [];
    }

    return SpareModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      savCode: json['savCode']?.toString() ?? '',
      spareCode: json['spareCode']?.toString() ?? '',
      supplier: json['supplier']?.toString() ?? '',
      compatibleMotorcycles: parseCompatibleMotorcycles(
        json['compatibleMotorcycles'],
      ),
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      purchasePriceWithVat: parseDouble(json['purchasePriceWithVat']),
      salePrice: parseDouble(json['salePrice']),
      isOil: json['isOil'] == true,
      warehouseLocation: json['warehouseLocation']?.toString() ?? '',
      stockThreshold: (json['stockThreshold'] as num?)?.toInt() ?? 0,
    );
  }
}
