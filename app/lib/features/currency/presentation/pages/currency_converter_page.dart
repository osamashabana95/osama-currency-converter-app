import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/currency_history_chart.dart';
import '../widgets/result_card.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Osama Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<CurrencyBloc, CurrencyState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CurrencyDropdown(
                          label: 'From Currency',
                          value: state.from,
                          onChanged: (v) {
                            context.read<CurrencyBloc>().add(
                              SelectFromCurrency(v!),
                            );
                          },
                          icon: Icons.arrow_upward,
                        ),
                        const SizedBox(height: 16),
                        CurrencyDropdown(
                          label: 'To Currency',
                          value: state.to,
                          onChanged: (v) {
                            context.read<CurrencyBloc>().add(
                              SelectToCurrency(v!),
                            );
                          },
                          icon: Icons.arrow_downward,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            prefixIcon: Icon(Icons.money),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            context.read<CurrencyBloc>().add(
                              AmountChangedEvent(value),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: state.isLoading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.swap_horiz),
                            label: const Text('Convert'),
                            onPressed:
                                state.from == null ||
                                    state.to == null ||
                                    state.amount == null
                                ? null
                                : () {
                                    context.read<CurrencyBloc>().add(
                                      ConvertCurrencyEvent(
                                        from: state.from!,
                                        to: state.to!,
                                        amount: state.amount!,
                                      ),
                                    );
                                    context.read<CurrencyBloc>().add(
                                      LoadCurrencyHistoryEvent(
                                        from: state.from!,
                                        to: state.to!,
                                      ),
                                    );
                                  },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (state.result != null) ResultCard(result: state.result!),

                const SizedBox(height: 24),
                if (state.isHistoryLoading) const CircularProgressIndicator(),
                if (state.history.isNotEmpty)
                  CurrencyHistoryChart(history: state.history),
              ],
            );
          },
        ),
      ),
    );
  }
}
