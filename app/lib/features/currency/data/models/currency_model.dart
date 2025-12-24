import '../../domain/entities/currency.dart';

class CurrencyModel extends Currency {
  CurrencyModel({
    required super.code,
    required super.name,
    required super.flagUrl,
  });

  factory CurrencyModel.fromJson(String code, Map<String, dynamic> json) {
    return CurrencyModel(
      code: code,
      name: json['description'] ?? '',
      flagUrl: '',
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'flagUrl': flagUrl,
  };
}
