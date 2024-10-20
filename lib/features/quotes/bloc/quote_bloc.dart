
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:retrofit_bloc_go_router_getit/features/quotes/repository/quote_repository.dart';
import 'package:retrofit_bloc_go_router_getit/model/quote/quote_model.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository _quoteRepository;
  QuoteBloc({required  QuoteRepository quoteRepository}) :_quoteRepository=quoteRepository,super(QuoteInitial()) {
    on<QuoteRequested>((event, emit) async{
      emit(QuoteLoading());
      final q=  await _quoteRepository.getQuote(event.quoteId);
      return emit(QuoteLoaded(quote: q));
    });
  }
}
