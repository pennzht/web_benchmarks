// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert' show JsonEncoder;

import 'package:flutter_test/flutter_test.dart';

import 'package:web_benchmarks/server/server.dart';

Future<void> main() async {
  test('Web benchmarks run successfully, returning correct keys', () async {
    final taskResult = await runWebBenchmark(
      macrobenchmarksDirectory: 'test/test_app',
      entryPoint: 'lib/benchmarks/runner.dart',
      useCanvasKit: false,
    );

    expect(taskResult.succeeded, true);

    for (final benchmarkName in ['scroll', 'page', 'tap']) {
      for (final metricName in ['preroll_frame', 'apply_frame', 'drawFrameDuration']) {
        for (final valueName in ['average', 'outlierAverage', 'outlierRatio', 'noise']) {
          expect(
            taskResult.data.keys,
            contains('$benchmarkName.html.$metricName.$valueName'),
          );

          if (metricName == 'drawFrameDuration' &&
              ['average', 'outlierRatio'].contains(valueName)) {
            expect(
              taskResult.benchmarkScoreKeys,
              contains('$benchmarkName.html.$metricName.$valueName'),
            );
          }
        }
      }
      expect(
        taskResult.data.keys,
        contains('$benchmarkName.html.totalUiFrame.average'),
      );

      expect(
        taskResult.benchmarkScoreKeys,
        contains('$benchmarkName.html.totalUiFrame.average'),
      );
    }

    print(JsonEncoder.withIndent('  ').convert(taskResult.toJson()));
  },
  timeout: Timeout(Duration(minutes: 3)));
}
