part of 'quote_bloc.dart';

sealed class QuoteEvent extends Equatable {
  const QuoteEvent();
}

final class QuoteRequested extends QuoteEvent {
  final String quoteId;
  const QuoteRequested(this.quoteId);
  @override
  List<Object> get props => [quoteId];
}