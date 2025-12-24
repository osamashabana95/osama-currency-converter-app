import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency_bloc.dart';
import '../bloc/currency_state.dart';

class CurrencyDropdown extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? value;
  final ValueChanged<String?> onChanged;

  const CurrencyDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      buildWhen: (prev, curr) =>
          prev.currencies != curr.currencies ||
          prev.from != curr.from ||
          prev.to != curr.to,
      builder: (context, state) {
        return DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            border: const OutlineInputBorder(),
          ),
          items: state.currencies
              .map(
                (currency) => DropdownMenuItem<String>(
                  value: currency.code,
                  child: Text(
                    '${currency.code} — ${currency.name}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
