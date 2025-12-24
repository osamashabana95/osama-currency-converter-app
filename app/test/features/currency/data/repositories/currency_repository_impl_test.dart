import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:osama_currency/features/currency/data/datasources/currency_local_datasource.dart';
import 'package:osama_currency/features/currency/data/datasources/currency_remote_datasource.dart';
import 'package:osama_currency/features/currency/data/models/currency_model.dart';
import 'package:osama_currency/features/currency/data/repositories/currency_repository_impl.dart';

class MockRemote extends Mock implements CurrencyRemoteDataSource {}

class MockLocal extends Mock implements CurrencyLocalDataSource {}

void main() {
  late CurrencyRepositoryImpl repository;
  late MockRemote remote;
  late MockLocal local;

  setUp(() {
    remote = MockRemote();
    local = MockLocal();
    repository = CurrencyRepositoryImpl(remote, local);
  });

  test('fetches currencies from remote and caches locally', () async {
    final models = [CurrencyModel(code: 'USD', name: 'US Dollar', flagUrl: '')];

    when(() => local.getCachedCurrencies()).thenAnswer((_) async => []);

    when(() => remote.getCurrencies()).thenAnswer((_) async => models);

    when(() => local.cacheCurrencies(any())).thenAnswer((_) async {});

    final result = await repository.getCurrencies();

    expect(result.first.code, 'USD');
    verify(() => remote.getCurrencies()).called(1);
    verify(() => local.cacheCurrencies(any())).called(1);
  });
}
