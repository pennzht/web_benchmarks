import 'dart:convert' show JsonEncoder;

import 'server/server.dart';

Future<void> main() async {
  final taskResult = await runWebBenchmark(
    macrobenchmarksDirectory: '.',
    entryPoint: 'test/test_app/benchmarks/runner.dart',
    useCanvasKit: false,
  );
  print(JsonEncoder.withIndent('  ').convert(taskResult.toJson()));
}
