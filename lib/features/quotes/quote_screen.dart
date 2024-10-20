import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit_bloc_go_router_getit/features/quotes/bloc/quote_bloc.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  int quoteId=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<QuoteBloc, QuoteState>(
            builder: (context, state) {
              if(state is QuoteLoading) {
                return const Text("Loading");
              }
              if(state is QuoteLoaded) {
                return Text(state.quote.quote);
              }
              return Container();
            },
          ),
          TextButton(onPressed: (){
            setState(() {
              quoteId++;
            });
            context.read<QuoteBloc>().add( QuoteRequested(quoteId.toString()));
          }, child: const Text("next Quote"))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<QuoteBloc>().add( QuoteRequested(quoteId.toString()));

  }
}
