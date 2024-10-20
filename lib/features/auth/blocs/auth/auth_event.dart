part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}
final class AuthLoginRequested extends AuthEvent{
  final SignInForm form;
  const AuthLoginRequested({required this.form});

  @override
  List<Object> get props => [form];
}

final class AuthStorageRequested extends AuthEvent {}

final class AuthLogoutRequested extends AuthEvent{}