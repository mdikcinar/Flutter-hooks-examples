import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:testing_flutter_hooks/src/future_hook.dart';

const imageHeight = 300.0;

extension Normalize on num {
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizeRangeMin = 0.0,
    num normalizeRangeMax = 1.0,
  ]) =>
      (normalizeRangeMax - normalizeRangeMin) * ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizeRangeMin;
}

class AnimationHook extends HookWidget {
  const AnimationHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      lowerBound: 0,
      upperBound: 1,
    );
    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      lowerBound: 0,
      upperBound: 1,
    );
    final controller = useScrollController();

    useEffect(() {
      controller.addListener(() {
        final newOpacity = max(imageHeight - controller.offset, 0);
        final normalized = newOpacity.normalized(0, imageHeight).toDouble();
        opacity.value = normalized;
        size.value = normalized;
      });
      return null;
    }, [controller]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1,
            child: FadeTransition(
              opacity: opacity,
              child: Image.network(
                url,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: controller,
              itemCount: 100,
              itemBuilder: (context, index) => ListTile(
                title: Text('Test $index'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
