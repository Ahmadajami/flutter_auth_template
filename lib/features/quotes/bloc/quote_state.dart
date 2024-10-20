part of 'quote_bloc.dart';

sealed class QuoteState extends Equatable {
  const QuoteState();
}

final class QuoteInitial extends QuoteState {
  @override
  List<Object> get props => [];
}
final class QuoteLoaded extends QuoteState{
  final QuoteModel quote;

  const QuoteLoaded({required this.quote});
  @override

  List<Object?> get props => [quote];

}
final class QuoteLoading extends QuoteState {
  @override
  List<Object> get props => [];
}
