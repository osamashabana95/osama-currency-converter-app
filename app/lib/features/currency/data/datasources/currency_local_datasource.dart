import '../models/currency_hive_model.dart';

abstract class CurrencyLocalDataSource {
  Future<void> cacheCurrencies(List<CurrencyHiveModel> currencies);

  Future<List<CurrencyHiveModel>> getCachedCurrencies();
}
