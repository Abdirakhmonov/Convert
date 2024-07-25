import 'package:currency_converter/bloc/currency_bloc.dart';
import 'package:currency_converter/bloc/currency_event.dart';
import 'package:currency_converter/repositories/bloc_observer.dart';
import 'package:currency_converter/repositories/currency_http.dart';
import 'package:currency_converter/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  Bloc.observer = CurrencyBlocObserver();
  runApp(const MainRunner());
}

class MainRunner extends StatelessWidget {
  const MainRunner({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => CurrencyHttpRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CurrencyBloc(
                currencyHttp: context.read<CurrencyHttpRepository>())
              ..add(GetCurrency()),
          )
        ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: Homepage(),
        ),
      ),
    );
  }
}
