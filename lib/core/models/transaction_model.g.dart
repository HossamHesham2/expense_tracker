// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(
  Map<String, dynamic> json,
) => TransactionModel(
  id: json['id'] as String?,
  title: json['title'] as String?,
  amount: (json['amount'] as num?)?.toDouble(),
  category: json['category'] as String?,
  transactionType: $enumDecodeNullable(
    _$TransactionTypeEnumMap,
    json['transactionType'],
  ),
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  accountType: $enumDecodeNullable(_$AccountTypeEnumMap, json['accountType']),
  note: json['note'] as String?,
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'amount': instance.amount,
      'category': instance.category,
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
      'date': instance.date?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'accountType': _$AccountTypeEnumMap[instance.accountType],
      'note': instance.note,
      'userId': instance.userId,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};

const _$AccountTypeEnumMap = {
  AccountType.cash: 'cash',
  AccountType.bankAccount: 'bankAccount',
  AccountType.debitCard: 'debitCard',
};
