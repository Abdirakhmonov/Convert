import 'dart:convert';
import 'package:currency_converter/models/currency.dart';
import 'package:http/http.dart' as http;

class CurrencyHttpRepository {
  Future<List<Currency>> fetchCurrencies() async {
    Uri url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/a1fb195a5e597666e18de2de/latest/USD');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final rates = data['conversion_rates'] as Map<String, dynamic>;
      print(rates);
      return rates.entries.map((entry) {
        return Currency(name: entry.key, currency: entry.value.toDouble());
      }).toList();
    } else {
      throw Exception('Failed to load currencies');
    }
  }
}
