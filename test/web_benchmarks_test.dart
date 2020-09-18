import 'dart:convert' show JsonEncoder;

import 'package:flutter_test/flutter_test.dart';

import 'server/server.dart';

Future<void> main() async {
  test('Web benchmarks run successfully, returning correct keys', () async {

  });

  final taskResult = await runWebBenchmark(
    macrobenchmarksDirectory: 'test/test_app',
    entryPoint: 'lib/benchmarks/runner.dart',
    useCanvasKit: false,
  );
  print(JsonEncoder.withIndent('  ').convert(taskResult.toJson()));
}
