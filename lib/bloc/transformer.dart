import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
