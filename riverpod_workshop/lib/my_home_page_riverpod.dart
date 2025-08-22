import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 👆 Riverpodを使うために追加が必要！


// StateProvider = 値を保持して、変更を通知してくれるProvider
final counterProvider = StateProvider<int>((ref) {
  return 0; // 初期値
});

// 🔄 StatefulWidget → ConsumerWidget に変更
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});
  
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 📖 ref.watch() でProviderの値を「監視」
    // 値が変わったら自動で再描画される！
    final counter = ref.watch(counterProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter', // ←ここでcounterを表示
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 🔄 setState() → ref.read() に変更
          // ref.read() は「一度だけ」値を取得・操作
          ref.read(counterProvider.notifier).state++;
          
          // または、より明示的に書くなら：
          // ref.read(counterProvider.notifier).update((state) => state + 1);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 🏁 main関数もRiverpod用に変更
void main() {
  runApp(
    // ProviderScope で全体を囲む（必須！）
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Counter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Riverpod Counter'),
    );
  }
}