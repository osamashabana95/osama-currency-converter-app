import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/currency_hive_model.dart';
import 'currency_local_datasource.dart';

@LazySingleton(as: CurrencyLocalDataSource)
class CurrencyLocalDataSourceImpl implements CurrencyLocalDataSource {
  static const _boxName = 'currencies';

  @override
  Future<void> cacheCurrencies(List<CurrencyHiveModel> currencies) async {
    final box = await Hive.openBox<CurrencyHiveModel>(_boxName);
    await box.clear();
    await box.addAll(currencies);
  }

  @override
  Future<List<CurrencyHiveModel>> getCachedCurrencies() async {
    final box = await Hive.openBox<CurrencyHiveModel>(_boxName);
    return box.values.toList();
  }
}
