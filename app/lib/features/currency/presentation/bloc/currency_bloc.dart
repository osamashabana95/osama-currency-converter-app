import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/convert_currency_usecase.dart';
import '../../domain/usecases/get_currencies_usecase.dart';
import '../../domain/usecases/get_currency_history_usecase.dart';
import 'currency_event.dart';
import 'currency_state.dart';

@injectable
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrenciesUseCase getCurrencies;
  final ConvertCurrencyUseCase convertCurrency;
  final GetCurrencyHistoryUseCase getHistoryUseCase;

  CurrencyBloc({
    required this.getCurrencies,
    required this.convertCurrency,
    required this.getHistoryUseCase,
  }) : super(const CurrencyState()) {
    on<LoadCurrenciesEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));

      try {
        final currencies = await getCurrencies();
        emit(state.copyWith(currencies: currencies, isLoading: false));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });

    on<AmountChangedEvent>((event, emit) {
      final parsed = double.tryParse(event.value);
      emit(state.copyWith(amount: parsed));
    });

    on<SelectFromCurrency>((event, emit) {
      emit(state.copyWith(from: event.from));
    });

    on<SelectToCurrency>((event, emit) {
      emit(state.copyWith(to: event.to));
    });

    on<ConvertCurrencyEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));

      try {
        final result = await convertCurrency(
          from: event.from,
          to: event.to,
          amount: event.amount,
        );

        emit(state.copyWith(isLoading: false, result: result));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });
    on<ResetConverterEvent>((event, emit) {
      emit(
        state.copyWith(
          from: null,
          to: null,
          amount: null,
          result: null,
          history: [],
        ),
      );
    });
    on<LoadCurrencyHistoryEvent>((event, emit) async {
      emit(state.copyWith(isHistoryLoading: true));

      try {
        final history = await getHistoryUseCase(from: event.from, to: event.to);

        emit(state.copyWith(history: history, isHistoryLoading: false));
      } catch (e) {
        emit(state.copyWith(isHistoryLoading: false));
      }
    });
  }
}
