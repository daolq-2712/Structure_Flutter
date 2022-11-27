import 'dart:async';

abstract class BaseBloc<Event, State> {
  BaseBloc(this.state);

  State state;

  final _eventController = StreamController<Event>();

  final _stateController = StreamController<State>();

  StreamController<Event> get eventController => _eventController;

  StreamController<State> get stateController => _stateController;

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}
