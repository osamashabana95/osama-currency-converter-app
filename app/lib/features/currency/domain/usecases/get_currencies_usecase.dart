import 'package:injectable/injectable.dart';

import '../entities/currency.dart';
import '../repositories/currency_repository.dart';

@lazySingleton
class GetCurrenciesUseCase {
  final CurrencyRepository repository;

  GetCurrenciesUseCase(this.repository);

  Future<List<Currency>> call() {
    return repository.getCurrencies();
  }
}
