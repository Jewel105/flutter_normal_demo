import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'utils/storage_util.dart';

void main() {
  // Report Flutter synchronization errors
  // 上报Flutter的同步异常
  FlutterExceptionHandler? onError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details);
    // TODO: Implement the error reporting logic
  };

  // Report Flutter asynchronous errors
  // 拦截异步错误
  ZoneSpecification zoneSpecification = ZoneSpecification(
    handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
        Object error, StackTrace stackTrace) {
      // Network errors do not need to be reported
      // 网络异常不上报
      // if (error is DioException || error is DioH2NotSupportedException) return;
      // TODO: Implement the error reporting logic
    },
  );

  Zone.current.fork(specification: zoneSpecification).run(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize the storage utility
    await StorageUtil.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
