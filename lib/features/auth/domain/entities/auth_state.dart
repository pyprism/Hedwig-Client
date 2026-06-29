import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hedwig_client/shared/models/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated({required HedwigUser user}) =
      Authenticated;
  const factory AuthState.mustChangePassword({required HedwigUser user}) =
      MustChangePassword;
}
