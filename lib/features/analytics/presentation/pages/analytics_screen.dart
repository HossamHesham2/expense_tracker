import 'package:expense_tracker/core/constants/svgs_name.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/widgets/custom_filter_chip.dart';
import 'package:expense_tracker/features/analytics/data/model/expense_Data.dart';
import 'package:expense_tracker/features/analytics/data/model/expense_category.dart';
import 'package:expense_tracker/features/analytics/presentation/widget/average_expense_card.dart';
import 'package:expense_tracker/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

enum FilterType { week, month, year }

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  FilterType selectedFilter = FilterType.month;

  List<ExpenseChartData> buildChartData(List<TransactionModel> transactions) {
    final Map<String, double> grouped = {};

    switch (selectedFilter) {
      case FilterType.week:
      case FilterType.month:
        for (final transaction in transactions) {
          final key = transaction.date!.day.toString();

          grouped[key] = (grouped[key] ?? 0) + (transaction.amount ?? 0);
        }
        break;

      case FilterType.year:
        for (final transaction in transactions) {
          final months = [
            '',
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
          ];

          final key = months[transaction.date!.month];

          grouped[key] = (grouped[key] ?? 0) + (transaction.amount ?? 0);
        }
        break;
    }

    return grouped.entries
        .map((e) => ExpenseChartData(day: e.key, total: e.value))
        .toList();
  }

  List<ExpenseCategory> buildChartCategories(
    List<TransactionModel> transactions,
  ) {
    final Map<String, double> grouped = {};

    switch (selectedFilter) {
      case FilterType.week:
      case FilterType.month:
        for (final transaction in transactions) {
          final key = transaction.category ?? "Other";

          grouped[key] = (grouped[key] ?? 0) + (transaction.amount ?? 0);
        }
        break;

      case FilterType.year:
        for (final transaction in transactions) {
          final months = [
            '',
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec',
          ];

          final key = months[transaction.date!.month];

          grouped[key] = (grouped[key] ?? 0) + (transaction.amount ?? 0);
        }
        break;
    }

    return grouped.entries
        .map((e) => ExpenseCategory(category: e.key, total: e.value))
        .toList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        final now = DateTime.now();

        final transactions = state.transactions.where((transaction) {
          if (transaction.transactionType != TransactionType.expense) {
            return false;
          }

          switch (selectedFilter) {
            case FilterType.week:
              return transaction.date != null &&
                  transaction.date!.isAfter(
                    now.subtract(const Duration(days: 7)),
                  );

            case FilterType.month:
              return transaction.date != null &&
                  transaction.date!.month == now.month &&
                  transaction.date!.year == now.year;

            case FilterType.year:
              return transaction.date != null &&
                  transaction.date!.year == now.year;
          }
        }).toList();

        final chartData = buildChartData(transactions);
        final chartCategory = buildChartCategories(transactions);
        print(chartData);
        print(chartCategory);
        final maxValue = chartData.isEmpty
            ? 1000.0
            : chartData.map((e) => e.total).reduce((a, b) => a > b ? a : b) *
                  1.2;
        final totalExpense = transactions.fold<double>(
          0.0,
          (sum, item) => sum + (item.amount ?? 0.0),
        );
        final days = selectedFilter == FilterType.month
            ? 30
            : transactions.length;
        final averageExpense = totalExpense / days;
        final currentMonthTransactions = state.transactions.where((t) {
          return t.transactionType == TransactionType.expense &&
              t.date != null &&
              t.date!.month == now.month &&
              t.date!.year == now.year;
        }).toList();

        final lastMonth = DateTime(now.year, now.month - 1);

        final lastMonthTransactions = state.transactions.where((t) {
          return t.transactionType == TransactionType.expense &&
              t.date != null &&
              t.date!.month == lastMonth.month &&
              t.date!.year == lastMonth.year;
        }).toList();

        final currentTotal = currentMonthTransactions.fold<double>(
          0.0,
          (sum, t) => sum + (t.amount ?? 0.0),
        );

        final lastTotal = lastMonthTransactions.fold<double>(
          0.0,
          (sum, t) => sum + (t.amount ?? 0.0),
        );
        double percentageChange = 0;

        if (lastTotal != 0) {
          percentageChange = ((currentTotal - lastTotal) / lastTotal) * 100;
        }

        if (transactions.isEmpty) {
          return const Center(child: Text("No expenses yet"));
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                _buildHeader(),
                SizedBox(height: 20.h),
                _buildFilters(),
                SizedBox(height: 20.h),
                _buildTitle(title: "Expenses Overview"),
                SizedBox(height: 30.h),

                SizedBox(
                  height: 220.h,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    margin: EdgeInsets.zero,

                    primaryXAxis: CategoryAxis(
                      axisLine: const AxisLine(width: 1),
                      majorGridLines: const MajorGridLines(width: 1),
                      majorTickLines: const MajorTickLines(size: 0),
                    ),

                    primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: maxValue,
                      interval: maxValue / 4,
                      axisLine: const AxisLine(width: 1),
                      majorTickLines: const MajorTickLines(size: 0),
                      majorGridLines: MajorGridLines(
                        width: 2,
                        color: Colors.grey.shade200,
                      ),
                    ),

                    series: [
                      ColumnSeries<ExpenseChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (data, _) => data.day,
                        yValueMapper: (data, _) => data.total,
                        color: AppColors.redEF44,
                        width: .45,
                        spacing: .3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                _buildTitle(title: "Top Categories"),
                SizedBox(height: 30.h),
                SizedBox(
                  height: 320.h,
                  child: SfCircularChart(
                    legend: Legend(isVisible: true),
                    series: <DoughnutSeries<ExpenseCategory, String>>[
                      DoughnutSeries(
                        dataSource: chartCategory,
                        xValueMapper: (data, _) => data.category,
                        yValueMapper: (data, _) => data.total,
                        innerRadius: '70%',
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                AverageExpenseCard(
                  amount: averageExpense,
                  percentageChange: percentageChange,
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
            "Analytics",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(SvgsName.add, width: 25.w),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle({required String title}) {
    return Text(
      title,
      style: context.bodyLarge.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20.sp,
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomFilterChip(
            label: "Week",
            selected: selectedFilter == FilterType.week,
            onTap: () {
              setState(() {
                selectedFilter = FilterType.week;
              });
            },
            color: AppColors.green16A3,
          ),
          SizedBox(width: 10.w),
          CustomFilterChip(
            label: "Month",
            selected: selectedFilter == FilterType.month,
            onTap: () {
              setState(() {
                selectedFilter = FilterType.month;
              });
            },
            color: AppColors.green16A3,
          ),
          SizedBox(width: 10.w),
          CustomFilterChip(
            label: "Year",
            selected: selectedFilter == FilterType.year,
            onTap: () {
              setState(() {
                selectedFilter = FilterType.year;
              });
            },
            color: AppColors.green16A3,
          ),
        ],
      ),
    );
  }
}
