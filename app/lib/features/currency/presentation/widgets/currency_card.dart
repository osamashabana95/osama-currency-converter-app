import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/currency.dart';

class CurrencyCard extends StatelessWidget {
  final Currency currency;

  const CurrencyCard({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CachedNetworkImage(
          imageUrl: currency.flagUrl,
          width: 40,
          height: 30,
          fit: BoxFit.cover,
        ),
        title: Text(
          currency.code,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(currency.name),
      ),
    );
  }
}
