import 'package:injectable/injectable.dart';

import '../../../../core/utils/currency_flag_mapper.dart';
import '../../domain/entities/currency.dart';
import '../../domain/entities/currency_history.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/currency_local_datasource.dart';
import '../datasources/currency_remote_datasource.dart';
import '../models/currency_hive_model.dart';

@LazySingleton(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remote;
  final CurrencyLocalDataSource local;

  CurrencyRepositoryImpl(this.remote, this.local);

  @override
  Future<List<Currency>> getCurrencies() async {
    final cached = await local.getCachedCurrencies();
    if (cached.isNotEmpty) {
      return cached
          .map((c) => Currency(code: c.code, name: c.name, flagUrl: c.flagUrl))
          .toList();
    }

    try {
      final remoteCurrencies = await remote.getCurrencies();

      final currencies = remoteCurrencies.map((model) {
        return Currency(
          code: model.code,
          name: model.name,
          flagUrl: getFlagUrl(model.code),
        );
      }).toList();
      currencies.sort((a, b) {
        if (a.code == 'USD') return -1;
        if (b.code == 'USD') return 1;
        if (a.code == 'EUR') return -1;
        if (b.code == 'EUR') return 1;
        if (a.code == 'ZAR') return -1;
        if (b.code == 'ZAR') return 1;
        if (a.code == 'PLN') return -1;
        if (b.code == 'PLN') return 1;
        if (a.code == 'MYR') return -1;
        if (b.code == 'MYR') return 1;
        if (a.code == 'JPY') return -1;
        if (b.code == 'JPY') return 1;
        if (a.code == 'KRW') return -1;
        if (b.code == 'KRW') return 1;
        if (a.code == 'INR') return -1;
        if (b.code == 'INR') return 1;
        if (a.code == 'NZD') return -1;
        if (b.code == 'NZD') return 1;
        if (a.code == 'SGD') return -1;
        if (b.code == 'SGD') return 1;
        return a.code.compareTo(b.code);
      });
      final sortedCurrencies = currencies.take(20).toList();

      await local.cacheCurrencies(
        sortedCurrencies
            .map(
              (c) => CurrencyHiveModel(
                code: c.code,
                name: c.name,
                flagUrl: c.flagUrl,
              ),
            )
            .toList(),
      );

      return sortedCurrencies;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<double> convertCurrency({
    required String from,
    required String to,
    required double amount,
  }) async {
    return remote.convertCurrency(from: from, to: to, amount: amount);
  }

  @override
  Future<Map<DateTime, double>> getHistoricalRates({
    required String base,
    required String target,
  }) async {
    return remote.getHistoricalRates(base: base, target: target);
  }

  @override
  Future<List<CurrencyHistory>> getHistory({
    required String from,
    required String to,
  }) {
    return remote.getHistory(from: from, to: to);
  }
}
