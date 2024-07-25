import 'package:bloc/bloc.dart';
import 'package:currency_converter/bloc/transformer.dart';
import '../repositories/currency_http.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyHttpRepository _currencyHttpRepository;

  CurrencyBloc({required CurrencyHttpRepository currencyHttp})
      : _currencyHttpRepository = currencyHttp,
        super(CurrencyInitial()) {
    on<GetCurrency>(_fetchCurrencies);
    on<SearchCurrency>(_searchCurrencies,
        transformer: debounce(const Duration(milliseconds: 300)));
  }

  void _fetchCurrencies(GetCurrency event, Emitter<CurrencyState> emit) async {
    try {
      emit(CurrencyLoading());
      final currencies = await _currencyHttpRepository.fetchCurrencies();
      emit(CurrencyLoaded(list: currencies));
    } catch (e) {
      emit(CurrencyError(errorText: e.toString()));
    }
  }

  void _searchCurrencies(
      SearchCurrency event, Emitter<CurrencyState> emit) async {
    try {
      final query = event.query.toLowerCase();
      if (state is CurrencyLoaded) {
        final currentState = state as CurrencyLoaded;
        final filteredCurrencies = currentState.list
            .where((currency) => currency.name.toLowerCase().contains(query))
            .toList();
        emit(CurrencyLoaded(list: filteredCurrencies));
      }
    } catch (e) {
      emit(CurrencyError(errorText: e.toString()));
    }
  }
}
