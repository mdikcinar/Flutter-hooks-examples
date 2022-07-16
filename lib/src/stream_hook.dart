import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Stream<String> getTime() => Stream.periodic(
      const Duration(seconds: 1),
      (_) => DateTime.now().toIso8601String(),
    );

class StreamHook extends HookWidget {
  const StreamHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = useStream<String>(getTime());
    return Scaffold(
      appBar: AppBar(
        title: Text(title.data ?? ''),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
