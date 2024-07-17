import 'package:bloc/bloc.dart';
import 'package:currency_converter/bloc/currency_event.dart';
import 'package:currency_converter/bloc/currency_state.dart';
import 'package:currency_converter/repositories/currency_http.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyHttpRepository _currencyHttpRepository;

  CurrencyBloc({required CurrencyHttpRepository currencyHttp})
      : _currencyHttpRepository = currencyHttp,
        super(CurrencyInitial()) {
    on<GetCurrency>(_fetchCurrencies);
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
}
