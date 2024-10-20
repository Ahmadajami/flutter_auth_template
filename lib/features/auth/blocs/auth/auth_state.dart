part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
final class AuthSuccess extends AuthState{
  final UserModel userModel;

 const  AuthSuccess({required this.userModel});
  @override
  List<Object> get props => [userModel];
}
final class AuthLoading extends AuthState{}

final class AuthFailure extends AuthState{
  final String errorMessage;
  const AuthFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];

}