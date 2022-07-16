import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:testing_flutter_hooks/src/future_hook.dart';

enum Action {
  rotateLeft,
  rotateRight,
  lessVisible,
  moreVisible,
}

@immutable
class State {
  final double rotationDeg;
  final double alpha;
  const State({
    required this.rotationDeg,
    required this.alpha,
  });

  const State.zero()
      : rotationDeg = 0.0,
        alpha = 1.0;

  State rotateRight() => copyWith(rotationDeg: rotationDeg + 10);
  State rotateLeft() => copyWith(rotationDeg: rotationDeg - 10);
  State increaseAlpha() => copyWith(alpha: min(alpha + 0.1, 1.0));
  State decreaseAlpha() => copyWith(alpha: max(alpha - 0.1, 0.0));

  State copyWith({double? rotationDeg, double? alpha}) =>
      State(rotationDeg: rotationDeg ?? this.rotationDeg, alpha: alpha ?? this.alpha);
}

State reducer(State oldState, Action? action) {
  switch (action) {
    case Action.rotateLeft:
      return oldState.rotateLeft();
    case Action.rotateRight:
      return oldState.rotateRight();
    case Action.lessVisible:
      return oldState.decreaseAlpha();
    case Action.moreVisible:
      return oldState.increaseAlpha();
    case null:
      return oldState;
  }
}

class ReducerHook extends HookWidget {
  const ReducerHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = useReducer<State, Action?>(
      reducer,
      initialState: const State.zero(),
      initialAction: null,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () => store.dispatch(Action.rotateLeft),
                child: const Text('Rotate left'),
              ),
              TextButton(
                onPressed: () => store.dispatch(Action.rotateRight),
                child: const Text('Rotate right'),
              ),
              TextButton(
                onPressed: () => store.dispatch(Action.lessVisible),
                child: const Text('Less visible'),
              ),
              TextButton(
                onPressed: () => store.dispatch(Action.moreVisible),
                child: const Text('More visible'),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Opacity(
                opacity: store.state.alpha,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(store.state.rotationDeg / 360),
                  child: Image.network(url),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
