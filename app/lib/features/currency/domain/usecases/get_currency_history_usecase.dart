import 'package:injectable/injectable.dart';

import '../entities/currency_history.dart';
import '../repositories/currency_repository.dart';

@lazySingleton
class GetCurrencyHistoryUseCase {
  final CurrencyRepository repository;

  GetCurrencyHistoryUseCase(this.repository);

  Future<List<CurrencyHistory>> call({
    required String from,
    required String to,
  }) {
    return repository.getHistory(from: from, to: to);
  }
}
