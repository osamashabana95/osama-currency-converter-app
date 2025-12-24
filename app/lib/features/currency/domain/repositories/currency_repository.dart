import '../entities/currency.dart';
import '../entities/currency_history.dart';

abstract class CurrencyRepository {
  Future<List<Currency>> getCurrencies();

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
