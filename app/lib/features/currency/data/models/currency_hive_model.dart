import 'package:hive/hive.dart';

part 'currency_hive_model.g.dart';

@HiveType(typeId: 1)
class CurrencyHiveModel extends HiveObject {
  @HiveField(0)
  String code;

  @HiveField(1)
  String name;

  @HiveField(2)
  String flagUrl;

  CurrencyHiveModel({
    required this.code,
    required this.name,
    required this.flagUrl,
  });
}
