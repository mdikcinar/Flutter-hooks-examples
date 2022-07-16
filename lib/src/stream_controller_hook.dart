import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:testing_flutter_hooks/src/future_hook.dart';

class StreamControllerHook extends HookWidget {
  const StreamControllerHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = useStreamController<double>(
      onListen: () => controller.sink.add(0.0),
    );
    final rotation = useStream(controller.stream);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: GestureDetector(
        onTap: () => controller.sink.add((rotation.data ?? 0) + 0.1),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(rotation.data ?? 0.0),
          child: Center(
            child: Image.network(url),
          ),
        ),
      ),
    );
  }
}
