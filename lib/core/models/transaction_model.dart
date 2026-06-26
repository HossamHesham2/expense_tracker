import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonEnum()
enum TransactionType {
  income,
  expense,
}

@JsonEnum()
enum AccountType {
  cash,
  bankAccount,
  debitCard,
}

@JsonSerializable(explicitToJson: true)
class TransactionModel {
  final String? id;
  final String? title;
  final double? amount;
  final String? category;
  final TransactionType? transactionType;
  final DateTime? date;
  final AccountType? accountType;
  final String? note;
  final String? userId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.transactionType,
    required this.date,
    required this.accountType,
    this.note,
    required this.userId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}