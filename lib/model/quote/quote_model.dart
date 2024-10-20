import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'quote_model.g.dart';

QuoteModel quoteModelFromJson(String str) => QuoteModel.fromJson(json.decode(str));

String quoteModelToJson(QuoteModel data) => json.encode(data.toJson());

@JsonSerializable()
class QuoteModel extends Equatable {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "quote")
  final String quote;
  @JsonKey(name: "author")
  final String author;

  const QuoteModel({
    required this.id,
    required this.quote,
    required this.author,
  });

  // Factory method for creating an instance from JSON
  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() => _$QuoteModelToJson(this);

  // Override the props getter to include all fields for comparison
  @override
  List<Object> get props => [id, quote, author];
}
