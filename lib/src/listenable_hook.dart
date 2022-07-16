import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CountDown extends ValueNotifier<int> {
  CountDown({required int from}) : super(from) {
    streamSubscription = Stream.periodic(
      const Duration(seconds: 1),
      (v) => from - v,
    ).takeWhile((value) => value >= 0).listen((value) => this.value = value);
  }

  late StreamSubscription<int> streamSubscription;

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }
}

class ListenableHook extends HookWidget {
  const ListenableHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(notifier.value.toString()),
      ),
    );
  }
}
