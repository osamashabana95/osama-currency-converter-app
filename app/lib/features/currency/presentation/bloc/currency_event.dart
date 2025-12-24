abstract class CurrencyEvent {}

class LoadCurrenciesEvent extends CurrencyEvent {}

class SelectFromCurrency extends CurrencyEvent {
  final String from;

  SelectFromCurrency(this.from);
}

class SelectToCurrency extends CurrencyEvent {
  final String to;

  SelectToCurrency(this.to);
}

class AmountChangedEvent extends CurrencyEvent {
  final String value;

  AmountChangedEvent(this.value);
}

class ConvertCurrencyEvent extends CurrencyEvent {
  final String from;
  final String to;
  final double amount;

  ConvertCurrencyEvent({
    required this.from,
    required this.to,
    required this.amount,
  });
}

class ResetConverterEvent extends CurrencyEvent {}

class LoadCurrencyHistoryEvent extends CurrencyEvent {
  final String from;
  final String to;

  LoadCurrencyHistoryEvent({required this.from, required this.to});
}
