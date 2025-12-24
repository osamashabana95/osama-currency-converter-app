import '../../domain/entities/currency_history.dart';
import '../models/currency_model.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CurrencyModel>> getCurrencies();

  Future<double> convertCurrency({
    required String from,
    required String to,
    required double amount,
  });

  Future<Map<DateTime, double>> getHistoricalRates({
    required String base,
    required String target,
  });

  Future<List<CurrencyHistory>> getHistory({
    required String from,
    required String to,
  });
}
