import 'package:currency_converter/models/currency.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> list;

  CurrencyLoaded({required this.list});
}

class CurrencyError extends CurrencyState {
  final String errorText;

  CurrencyError({required this.errorText});
}
