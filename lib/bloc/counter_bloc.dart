import 'package:flutter_bloc/flutter_bloc.dart';

enum CounterEvents { increment, decrement }

class CounterBloc extends Bloc<CounterEvents, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvents event) async* {
    switch (event) {
      case CounterEvents.increment:
        yield state + 1; // yeld retorna o value sem terminar a funcao
        break;
      case CounterEvents.decrement:
        yield state != 0 ? state - 1 : 0;
        break;
      default:
        addError(Exception('unhandled event: $event'));
    }
  }
}
