import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements FlutterSecureStorage {}

/// In-memory stand-in so TokenStorage's writes/reads don't hit the
/// (unavailable in tests) platform secure-storage channel.
FlutterSecureStorage fakeSecureStorage() {
  final values = <String, String>{};
  final storage = MockSecureStorage();
  when(
    () => storage.write(
      key: any(named: 'key'),
      value: any(named: 'value'),
      iOptions: any(named: 'iOptions'),
      aOptions: any(named: 'aOptions'),
      lOptions: any(named: 'lOptions'),
      webOptions: any(named: 'webOptions'),
      mOptions: any(named: 'mOptions'),
      wOptions: any(named: 'wOptions'),
    ),
  ).thenAnswer((invocation) async {
    final key = invocation.namedArguments[#key] as String;
    final value = invocation.namedArguments[#value] as String?;
    if (value == null) {
      values.remove(key);
    } else {
      values[key] = value;
    }
  });
  when(
    () => storage.read(
      key: any(named: 'key'),
      iOptions: any(named: 'iOptions'),
      aOptions: any(named: 'aOptions'),
      lOptions: any(named: 'lOptions'),
      webOptions: any(named: 'webOptions'),
      mOptions: any(named: 'mOptions'),
      wOptions: any(named: 'wOptions'),
    ),
  ).thenAnswer(
    (invocation) async => values[invocation.namedArguments[#key] as String],
  );
  when(
    () => storage.delete(
      key: any(named: 'key'),
      iOptions: any(named: 'iOptions'),
      aOptions: any(named: 'aOptions'),
      lOptions: any(named: 'lOptions'),
      webOptions: any(named: 'webOptions'),
      mOptions: any(named: 'mOptions'),
      wOptions: any(named: 'wOptions'),
    ),
  ).thenAnswer((invocation) async {
    values.remove(invocation.namedArguments[#key] as String);
  });
  return storage;
}
