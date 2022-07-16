import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppLifeCycleStateHook extends HookWidget {
  const AppLifeCycleStateHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useAppLifecycleState();
    debugPrint(state.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Visibility(
        visible: state == AppLifecycleState.resumed,
        child: const Center(
          child: Text('Hide this text'),
        ),
      ),
    );
  }
}
