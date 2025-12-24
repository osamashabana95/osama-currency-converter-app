import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:osama_currency/features/currency/presentation/bloc/currency_event.dart';

import 'features/currency/data/models/currency_hive_model.dart';
import 'features/currency/presentation/bloc/currency_bloc.dart';
import 'features/currency/presentation/pages/currency_list_page.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CurrencyHiveModelAdapter());

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CurrencyBloc>()..add(LoadCurrenciesEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Osama Currency',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
        home: const CurrencyListPage(),
      ),
    );
  }
}
