abstract class CurrencyEvent {}

class GetCurrency extends CurrencyEvent {}

class SearchCurrency extends CurrencyEvent {
  final String query;

  SearchCurrency({required this.query});
}
