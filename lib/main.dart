import 'package:flutter/material.dart';
import 'package:testing_flutter_hooks/src/animation_hook.dart';
import 'package:testing_flutter_hooks/src/app_life_cycle_state_hook.dart';
import 'package:testing_flutter_hooks/src/future_hook.dart';
import 'package:testing_flutter_hooks/src/listenable_hook.dart';
import 'package:testing_flutter_hooks/src/reducer_hook.dart';
import 'package:testing_flutter_hooks/src/stream_controller_hook.dart';
import 'package:testing_flutter_hooks/src/stream_hook.dart';
import 'package:testing_flutter_hooks/src/text_editing_controller_hook.dart';

void main() => runApp(const App());

enum Pages {
  streamHook,
  streamControllerHook,
  appLifeCycleHook,
  futureHook,
  listenableHook,
  reducerHook,
  textEditingControllerHook,
  animationHook;

  String get path {
    switch (this) {
      case Pages.streamHook:
        return '/stream-hook';
      case Pages.streamControllerHook:
        return '/stream-controller-hook';
      case Pages.appLifeCycleHook:
        return '/app-life-cycle-hook';
      case Pages.futureHook:
        return '/future-hook';
      case Pages.listenableHook:
        return '/listenable-hook';
      case Pages.reducerHook:
        return '/reducer-hook';
      case Pages.textEditingControllerHook:
        return '/text-editing-controller-hook';
      case Pages.animationHook:
        return '/animation-hook';
    }
  }
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const HomePage(),
      routes: {
        Pages.streamHook.path: (context) => const StreamHook(),
        Pages.streamControllerHook.path: (context) => const StreamControllerHook(),
        Pages.animationHook.path: (context) => const AnimationHook(),
        Pages.appLifeCycleHook.path: (context) => const AppLifeCycleStateHook(),
        Pages.futureHook.path: (context) => const FutureHook(),
        Pages.listenableHook.path: (context) => const ListenableHook(),
        Pages.reducerHook.path: (context) => const ReducerHook(),
        Pages.textEditingControllerHook.path: (context) => const TextEditingControllerHook(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hook examples'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var page in Pages.values)
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(page.path),
              child: Text(page.name),
            )
        ],
      ),
    );
  }
}
