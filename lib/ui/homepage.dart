import 'package:currency_converter/bloc/currency_bloc.dart';
import 'package:currency_converter/bloc/currency_state.dart';
import 'package:currency_converter/ui/convertation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency_event.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                context.read<CurrencyBloc>().add(SearchCurrency(query: query));
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                labelText: 'Search Currency',
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CurrencyLoaded) {
                  return ListView.separated(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      final currency = state.list[index];
                      return ListTile(
                        title: Text(
                          currency.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          'Rate: ${currency.currency}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ConvertationScreen(currency: currency),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                  );
                } else if (state is CurrencyError) {
                  return Center(child: Text('Error: ${state.errorText}'));
                } else {
                  return const Center(child: Text('Failed to load currencies'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
