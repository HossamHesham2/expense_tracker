import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/widgets/transaction_card.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

enum FilterType { all, income, expense }

class _TransactionsScreenState extends State<TransactionsScreen> {
  FilterType selectedFilter = FilterType.all;

  @override
  void initState() {
    super.initState();
    context.read<TransactionsBloc>().add(const GetAllTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state.transactionsRequest == TransactionsRequest.loading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.green16A3),
            ),
          );
        }

        if (state.transactionsRequest == TransactionsRequest.error) {
          return Scaffold(
            body: Center(
              child: Text(
                state.transactionsFailure?.errMessage ?? "Something went wrong",
              ),
            ),
          );
        }

        final transactions = _filterTransactions(state.transactions);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),

                SizedBox(height: 20.h),

                _buildFilters(),

                SizedBox(height: 20.h),

                Expanded(
                  child: transactions.isEmpty
                      ? const Center(child: Text("No Transactions"))
                      : _buildTransactionsList(transactions),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Transactions",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(SvgsName.searchSharp),
              ),
              SizedBox(width: 20.w),
              GestureDetector(onTap: () {}, child: SvgPicture.asset(SvgsName.filter)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FilterChip(
            label: "All",
            selected: selectedFilter == FilterType.all,
            onTap: () {
              setState(() {
                selectedFilter = FilterType.all;
              });
            },
            color: Colors.black,
          ),
          SizedBox(width: 10.w),
          _FilterChip(
            label: "Income",
            selected: selectedFilter == FilterType.income,
            onTap: () {
              setState(() {
                selectedFilter = FilterType.income;
              });
            },
            color: AppColors.green16A3,
          ),
          SizedBox(width: 10.w),
          _FilterChip(
            label: "Expense",
            selected: selectedFilter == FilterType.expense,
            onTap: () {
              setState(() {
                selectedFilter = FilterType.expense;
              });
            },
            color: AppColors.redEF44,
          ),
        ],
      ),
    );
  }

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

  List<TransactionModel> _filterTransactions(
    List<TransactionModel> transactions,
  ) {
    switch (selectedFilter) {
      case FilterType.all:
        return transactions;

      case FilterType.income:
        return transactions
            .where((e) => e.transactionType == TransactionType.income)
            .toList();

      case FilterType.expense:
        return transactions
            .where((e) => e.transactionType == TransactionType.expense)
            .toList();
    }
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final current = DateTime(date.year, date.month, date.day);

    if (current == today) {
      return "Today";
    }

    if (current == yesterday) {
      return "Yesterday";
    }

    return DateFormat("MMM d, yyyy").format(date);
  }

  Widget _buildTransactionsList(List<TransactionModel> transactions) {
    String? lastHeader;

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        final header = _formatDateHeader(transaction.date ?? DateTime.now());

        final showHeader = header != lastHeader;

        lastHeader = header;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showHeader)
              Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 10.h),
                child: Text(
                  header,
                  style: context.titleSmall.copyWith(color: AppColors.gray6B72),
                ),
              ),

            TransactionCard(
              title: transaction.title,
              category: transaction.category,
              amount: transaction.amount,
              date: transaction.date,
              type: transaction.transactionType,
              svgIcon: svgName(transaction.category ?? ""),
            ),

            SizedBox(height: 12.h),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color color;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: selected ? color : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
