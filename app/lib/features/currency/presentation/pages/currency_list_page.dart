import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency_bloc.dart';
import '../bloc/currency_event.dart';
import '../bloc/currency_state.dart';
import '../widgets/currency_card.dart';
import 'currency_converter_page.dart';

class CurrencyListPage extends StatelessWidget {
  const CurrencyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Osama Currencies'),
        centerTitle: true,
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state.isLoading && state.currencies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.currencies.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return CurrencyCard(currency: state.currencies[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.swap_horiz),
        label: const Text('Convert'),
        onPressed: () {
          context.read<CurrencyBloc>().add(ResetConverterEvent());

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CurrencyConverterPage()),
          );
        },
      ),
    );
  }
}
