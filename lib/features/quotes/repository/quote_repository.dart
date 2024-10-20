import 'package:retrofit_bloc_go_router_getit/core/network/rest_client/rest_client.dart';
import 'package:retrofit_bloc_go_router_getit/model/quote/quote_model.dart';

abstract class QuoteRepository{
  Future <QuoteModel> getQuote(String id);
}
class  QuoteRepositoryI extends QuoteRepository{
  final RestClient _client;

  QuoteRepositoryI({required RestClient client}) : _client = client;

  @override
  Future<QuoteModel> getQuote(String id) async{
    return await _client.getQuote(id);
  }



}