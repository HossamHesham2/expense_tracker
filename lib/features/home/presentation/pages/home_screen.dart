import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/widgets/transaction_card.dart';
import 'package:expense_tracker/core/widgets/transaction_card_shimmer.dart';
import 'package:expense_tracker/features/home/presentation/widget/balance_card.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = false;

  @override
  void initState() {
    context.read<TransactionsBloc>().add(GetAllTransactionsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        final transactions = state.transactions;

        double income = 0;
        double expense = 0;

        for (final transaction in transactions) {
          if (transaction.transactionType == TransactionType.income) {
            income += transaction.amount ?? 0;
          } else {
            expense += transaction.amount ?? 0;
          }
        }

        final balance = income - expense;
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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(SvgsName.menuOutline),
                        SvgPicture.asset(SvgsName.notificationsOutline),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "Good morning 👋",
                              style: context.headlineLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.gray6B72,
                              ),
                            ),
                            subtitle: Text(
                              user?.displayName ?? "Guest",
                              style: context.headlineSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.emerald10B9,
                            borderRadius: BorderRadius.circular(200.r),
                          ),
                          child: SvgPicture.asset(
                            SvgsName.user,
                            width: 30.w,
                            color: AppColors.whiteFFFF,
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    BalanceCard(
                      balance: balance,
                      income: income,
                      expense: expense,
                      isVisible: isVisible,
                      onToggleVisibility: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Transactions",
                          style: context.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "See all",
                            style: context.labelLarge.copyWith(
                              color: AppColors.grayE5E7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    state.transactions.isEmpty
                        ? SizedBox(
                            height: 200.h,
                            child: Center(
                              child: Text(
                                "No data fount",
                                style: context.titleLarge,
                              ),
                            ),
                          )
                        : state.transactionsRequest ==
                              TransactionsRequest.loading
                        ? SizedBox(
                            height: 400.h,

                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 0.w),
                                itemCount: 5,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (_, __) =>
                                    const TransactionCardShimmer(),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.transactions.length > 5
                                ? 5
                                : state.transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = state.transactions[index];
                              return TransactionCard(
                                title: transaction.title,
                                category: transaction.category,
                                amount: transaction.amount,
                                date: transaction.date,
                                type: transaction.transactionType,
                                svgIcon: svgName(transaction.category ?? ""),
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RoutesName.transactionDetails,
                                  arguments: transaction,
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
