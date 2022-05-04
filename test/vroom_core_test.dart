import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vroom_core/vroom_core.dart';

void main() {
  const MethodChannel channel = MethodChannel('vroom_core');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await VroomCore.platformVersion, '42');
  });
}
