import 'package:injectable/injectable.dart';

import '../repositories/currency_repository.dart';

@lazySingleton
class ConvertCurrencyUseCase {
  final CurrencyRepository repository;

  ConvertCurrencyUseCase(this.repository);

  Future<double> call({
    required String from,
    required String to,
    required double amount,
  }) {
    return repository.convertCurrency(from: from, to: to, amount: amount);
  }
}
