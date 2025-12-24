import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:osama_currency/features/currency/domain/entities/currency.dart';
import 'package:osama_currency/features/currency/domain/repositories/currency_repository.dart';
import 'package:osama_currency/features/currency/domain/usecases/get_currencies_usecase.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late GetCurrenciesUseCase useCase;
  late MockCurrencyRepository repository;

  setUp(() {
    repository = MockCurrencyRepository();
    useCase = GetCurrenciesUseCase(repository);
  });

  test('should return list of currencies', () async {
    // arrange
    final currencies = [
      Currency(code: 'USD', name: 'US Dollar', flagUrl: ""),
      Currency(code: 'EUR', name: 'Euro', flagUrl: ""),
    ];

    when(() => repository.getCurrencies()).thenAnswer((_) async => currencies);

    // act
    final result = await useCase();

    // assert
    expect(result, currencies);
    verify(() => repository.getCurrencies()).called(1);
  });
}
