import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({super.key});

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  late TransactionModel transaction;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;

    transaction =
        ModalRoute.of(context)!.settings.arguments as TransactionModel;
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpense =
        transaction.transactionType == TransactionType.expense;
    final Color amountColor = isExpense
        ? AppColors.redEF44
        : AppColors.green16A3;
    String svgName(String category) {
      switch (category.trim().toLowerCase()) {
        case 'salary':
          return SvgsName.dollar;

        case 'food':
          return SvgsName.fastFoodOutline;

        case 'transport':
          return SvgsName.carFront;

        case 'shopping':
          return SvgsName.shoppingBag;

        case 'bills':
          return SvgsName.bill;

        case 'health':
          return SvgsName.heart;

        case 'education':
          return SvgsName.bookHalf;

        case 'other':
          return SvgsName.dotsHorizontal;

        default:
          return SvgsName.add;
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: SvgPicture.asset(SvgsName.chevronLeft, fit: BoxFit.scaleDown),
        ),
        leadingWidth: 30.w,
        title: Text("Transaction Details", style: context.titleLarge),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // ── Icon + Amount + Title + Badge ──────────────────────────
              Center(
                child: Column(
                  children: [
                    // Category icon circle
                    Container(
                      width: 72.w,
                      height: 72.w,
                      decoration: BoxDecoration(
                        color: isExpense
                            ? AppColors.redEF44.withAlpha(90)
                            : AppColors.green16A3.withAlpha(90),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          svgName(transaction.category ?? SvgsName.shoppingBag),
                          width: 32.w,
                          height: 32.w,
                          colorFilter: isExpense
                              ? ColorFilter.mode(
                                  AppColors.redEF44,
                                  BlendMode.srcIn,
                                )
                              : ColorFilter.mode(
                                  AppColors.green16A3,
                                  BlendMode.srcIn,
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Amount
                    Text(
                      '${isExpense ? '-' : '+'} ${transaction.amount?.toStringAsFixed(2) ?? '0.00'} EG',
                      style: context.headlineLarge.copyWith(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: amountColor,
                      ),
                    ),

                    SizedBox(height: 6.h),

                    // Transaction title
                    Text(
                      transaction.title ?? '',
                      style: context.bodyMedium.copyWith(
                        color: AppColors.gray6B72,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Type badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: amountColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        isExpense ? 'Expense' : 'Income',
                        style: context.labelSmall.copyWith(
                          color: AppColors.whiteFFFF,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // ── Details rows ───────────────────────────────────────────
              _DetailRow(
                label: 'Category',
                value: transaction.category ?? '',
                valueColor: isExpense ? AppColors.redEF44 : AppColors.green16A3,
              ),
              _DetailRow(
                label: 'Date',
                value: DateFormat('dd MMM yyyy').format(transaction.date!),
              ),
              _DetailRow(
                label: 'Time',
                value: DateFormat('hh:mm a').format(transaction.date!),
              ),
              _DetailRow(
                label: 'Account',
                value: transaction.accountType!.name.toUpperCase(),
                valueColor: isExpense ? AppColors.redEF44 : AppColors.green16A3,
              ),

              SizedBox(height: 20.h),

              Text(
                'Note',
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark1118,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                transaction.note ?? '',
                style: context.bodyMedium.copyWith(color: AppColors.gray6B72),
              ),

              const Spacer(),

              // ── Edit / Delete buttons ──────────────────────────────────
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: Row(
                  children: [
                    // Edit
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            RoutesName.editTransaction,
                            arguments: transaction,
                          );

                          if (result is TransactionModel && mounted) {
                            setState(() {
                              transaction = result;
                            });

                            context.read<TransactionsBloc>().add(
                              const GetAllTransactionsEvent(),
                            );
                          }
                        },
                        icon: SvgPicture.asset(
                          SvgsName.pencil,
                          width: 18.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.green16A3,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: Text(
                          'Edit',
                          style: context.bodyMedium.copyWith(
                            color: AppColors.green16A3,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.green16A3),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 16.w),

                    // Delete
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          SvgsName.trash,
                          width: 18.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.redEF44,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: Text(
                          'Delete',
                          style: context.bodyMedium.copyWith(
                            color: AppColors.redEF44,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.redEF44),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable detail row ──────────────────────────────────────────────────────
class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: context.bodyMedium.copyWith(color: AppColors.gray6B72),
                ),
              ),
              Text(
                value,
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: valueColor ?? AppColors.dark1118,
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: AppColors.gray6B72.withAlpha(90)),
      ],
    );
  }
}
