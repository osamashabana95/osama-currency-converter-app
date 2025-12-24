import 'package:injectable/injectable.dart';

import '../repositories/currency_repository.dart';

@lazySingleton
class GetHistoricalRatesUseCase {
  final CurrencyRepository repository;

  GetHistoricalRatesUseCase(this.repository);

  Future<Map<DateTime, double>> call({
    required String base,
    required String target,
  }) {
    return repository.getHistoricalRates(base: base, target: target);
  }
}
