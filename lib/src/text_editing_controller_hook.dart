import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextEditingControllerHook extends HookWidget {
  const TextEditingControllerHook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();
    final text = useState('');
    useEffect(() {
      textEditingController.addListener(() {
        text.value = textEditingController.text;
      });
      return null;
    }, [textEditingController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hooks'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
          ),
          Text('You typed ${text.value}'),
        ],
      ),
    );
  }
}
