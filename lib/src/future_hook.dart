import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

extension ContactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([E? Function(T?)? transform]) => map(
        transform ?? (e) => e,
      ).where((e) => e != null).cast();
}

const url = 'https://picsum.photos/300';

final getImage = NetworkAssetBundle(Uri.parse(url))
    .load(url)
    .then((data) => data.buffer.asUint8List())
    .then((data) => Image.memory(data));

class FutureHook extends HookWidget {
  const FutureHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => getImage);
    final image = useFuture(future);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Column(
        children: [
          image.data,
        ].compactMap().toList(),
      ),
    );
  }
}
