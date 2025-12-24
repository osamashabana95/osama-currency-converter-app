import 'package:injectable/injectable.dart';

import '../../../../core/network/dio_client.dart';
import '../../domain/entities/currency_history.dart';
import '../models/currency_model.dart';
import 'currency_remote_datasource.dart';

@LazySingleton(as: CurrencyRemoteDataSource)
class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final DioClient dioClient;

  CurrencyRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<CurrencyModel>> getCurrencies() async {
    final response = await dioClient.get('/currencies');

    final data = response.data as Map<String, dynamic>;

    return data.entries.map((e) {
      return CurrencyModel(code: e.key, name: e.value, flagUrl: '');
    }).toList();
  }

  @override
  Future<double> convertCurrency({
    required String from,
    required String to,
    required double amount,
  }) async {
    final response = await dioClient.get(
      '/latest',
      queryParameters: {'amount': amount, 'from': from, 'to': to},
    );

    return (response.data['rates'][to] as num).toDouble();
  }

  @override
  Future<Map<DateTime, double>> getHistoricalRates({
    required String base,
    required String target,
  }) async {
    final end = DateTime.now();
    final start = end.subtract(const Duration(days: 7));

    final path = '/${_format(start)}..${_format(end)}';

    final response = await dioClient.get(
      path,
      queryParameters: {'from': base, 'to': target},
    );

    final rates = response.data['rates'] as Map<String, dynamic>;

    return rates.map((date, value) {
      return MapEntry(DateTime.parse(date), (value[target] as num).toDouble());
    });
  }

  String _format(DateTime date) {
    return date.toIso8601String().split('T').first;
  }

  @override
  Future<List<CurrencyHistory>> getHistory({
    required String from,
    required String to,
  }) async {
    final end = DateTime.now();
    final start = end.subtract(const Duration(days: 7));

    final response = await dioClient.get(
      '/${_formatHistory(start)}..${_formatHistory(end)}',
      queryParameters: {'from': from, 'to': to},
    );

    final rates = response.data['rates'] as Map<String, dynamic>;

    return rates.entries.map((e) {
      final rate = (e.value as Map<String, dynamic>)[to];
      return CurrencyHistory(
        date: DateTime.parse(e.key),
        rate: (rate as num).toDouble(),
      );
    }).toList();
  }

  String _formatHistory(DateTime date) {
    return date.toIso8601String().split('T').first;
  }
}
