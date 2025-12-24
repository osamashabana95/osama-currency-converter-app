import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:osama_currency/features/currency/domain/entities/currency.dart';
import 'package:osama_currency/features/currency/domain/usecases/convert_currency_usecase.dart';
import 'package:osama_currency/features/currency/domain/usecases/get_currencies_usecase.dart';
import 'package:osama_currency/features/currency/domain/usecases/get_currency_history_usecase.dart';
import 'package:osama_currency/features/currency/presentation/bloc/currency_bloc.dart';
import 'package:osama_currency/features/currency/presentation/bloc/currency_event.dart';
import 'package:osama_currency/features/currency/presentation/bloc/currency_state.dart';

class MockGetCurrenciesUseCase extends Mock implements GetCurrenciesUseCase {}

class MockConvertCurrencyUseCase extends Mock
    implements ConvertCurrencyUseCase {}

class MockGetCurrencyHistoryUseCase extends Mock
    implements GetCurrencyHistoryUseCase {}

void main() {
  late CurrencyBloc bloc;
  late MockGetCurrenciesUseCase getCurrencies;
  late MockConvertCurrencyUseCase convertCurrency;
  late MockGetCurrencyHistoryUseCase getCurrencyHistory;

  setUp(() {
    getCurrencies = MockGetCurrenciesUseCase();
    convertCurrency = MockConvertCurrencyUseCase();
    getCurrencyHistory = MockGetCurrencyHistoryUseCase();

    bloc = CurrencyBloc(
      getCurrencies: getCurrencies,
      convertCurrency: convertCurrency,
      getHistoryUseCase: getCurrencyHistory,
    );
  });

  blocTest<CurrencyBloc, CurrencyState>(
    'emits loading=true then currencies loaded',
    build: () {
      when(() => getCurrencies()).thenAnswer(
        (_) async => [Currency(code: 'USD', name: 'Dollar', flagUrl: '')],
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoadCurrenciesEvent()),
    expect: () => [
      // loading state
      isA<CurrencyState>().having((s) => s.isLoading, 'isLoading', true),

      // loaded state
      isA<CurrencyState>()
          .having((s) => s.isLoading, 'isLoading', false)
          .having((s) => s.currencies.isNotEmpty, 'currencies', true),
    ],
  );
  /*
  blocTest<CurrencyBloc, CurrencyState>(
    'emits [Loading, Loaded] when currencies loaded',
    build: () {
      when(() => getCurrencies())
          .thenAnswer((_) async => [
        Currency(code: 'USD', name: 'Dollar', flagUrl: ''),
      ]);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadCurrenciesEvent()),
    expect: () => [
      isA<CurrencyLoading>(),
      isA<CurrencyLoaded>(),
    ],
  );*/
}
