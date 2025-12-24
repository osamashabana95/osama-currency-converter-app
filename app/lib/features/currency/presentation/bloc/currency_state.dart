import '../../domain/entities/currency.dart';
import '../../domain/entities/currency_history.dart';

class CurrencyState {
  final List<Currency> currencies;
  final List<CurrencyHistory> history;
  final bool isHistoryLoading;
  final String? from;
  final String? to;
  final double? amount;
  final double? result;
  final bool isLoading;
  final String? error;

  const CurrencyState({
    this.currencies = const [],
    this.from,
    this.to,
    this.amount,
    this.result,
    this.isLoading = false,
    this.error,
    this.history = const [],
    this.isHistoryLoading = false,
  });

  CurrencyState copyWith({
    List<Currency>? currencies,
    String? from,
    String? to,
    double? amount,
    double? result,
    bool? isLoading,
    String? error,
    List<CurrencyHistory>? history,
    bool? isHistoryLoading,
  }) {
    return CurrencyState(
      currencies: currencies ?? this.currencies,
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount,
      result: result,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      history: history ?? this.history,
      isHistoryLoading: isHistoryLoading ?? this.isHistoryLoading,
    );
  }

  @override
  List<Object?> get props => [
    currencies,
    from,
    to,
    amount,
    result,
    isLoading,
    error,
    history,
    isHistoryLoading,
  ];
}
