import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';


final appconfigProvider = Provider<AppConfig>((ref){
  return AppConfig(
    appname: 'Riverpod Workshop',
    version: '1.0.0',
    isDevelopment: true,
  );
});

class AppConfig {
  final String appname;
  final String version;
  final bool isDevelopment;

  const AppConfig({
    required this.appname,
    required this.version,
    required this.isDevelopment,
  });
}

class ConfigDisplay extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appconfigProvider);
    
    return Column(
      children: [
        Text('アプリ名: ${config.appname}'),
        Text('バージョン: ${config.version}'),
        Text('開発モード: ${config.isDevelopment}'),
      ],
    );
  }
}