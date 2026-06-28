import 'package:flutter_test/flutter_test.dart';
import 'package:hedwig_client/features/auth/domain/entities/auth_state.dart';
import 'package:hedwig_client/shared/models/user.dart';

const _staffUser = HedwigUser(
  id: 'u1',
  username: 'admin',
  email: 'admin@test.com',
  isStaff: true,
);

const _regularUser = HedwigUser(
  id: 'u2',
  username: 'alice',
  email: 'alice@test.com',
);

const _mustChangeUser = HedwigUser(
  id: 'u3',
  username: 'bob',
  email: 'bob@test.com',
  mustChangePassword: true,
);

void main() {
  group('AuthState guards', () {
    test('unauthenticated is not authenticated', () {
      const state = AuthState.unauthenticated();
      expect(state, isA<Unauthenticated>());
    });

    test('authenticated carries user', () {
      const state = AuthState.authenticated(user: _regularUser);
      expect(state, isA<Authenticated>());
      const auth = state as Authenticated;
      expect(auth.user.username, 'alice');
      expect(auth.user.isStaff, isFalse);
    });

    test('staff user has isStaff=true', () {
      const state = AuthState.authenticated(user: _staffUser);
      const auth = state as Authenticated;
      expect(auth.user.isStaff, isTrue);
    });

    test('mustChangePassword gate is separate state', () {
      const state = AuthState.mustChangePassword(user: _mustChangeUser);
      expect(state, isA<MustChangePassword>());
      const gate = state as MustChangePassword;
      expect(gate.user.mustChangePassword, isTrue);
    });

    test('pattern match covers all variants', () {
      final states = [
        const AuthState.unauthenticated(),
        const AuthState.authenticated(user: _regularUser),
        const AuthState.mustChangePassword(user: _mustChangeUser),
      ];
      for (final s in states) {
        final label = switch (s) {
          Unauthenticated() => 'unauthed',
          Authenticated() => 'authed',
          MustChangePassword() => 'must-change',
          _ => 'unknown',
        };
        expect(label, isNot('unknown'));
      }
    });
  });
}
