import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:expense_tracker/core/constants/routes_name.dart';
import 'package:expense_tracker/core/models/transaction_model.dart';
import 'package:expense_tracker/core/utils/app_validators.dart';
import 'package:expense_tracker/core/widgets/custom_snack_bar.dart';
import 'package:expense_tracker/core/widgets/custom_text_field.dart';
import 'package:expense_tracker/core/widgets/primary_button.dart';
import 'package:expense_tracker/features/add_transactions/data/model/category_item_model.dart';
import 'package:expense_tracker/features/add_transactions/presentation/bloc/add_transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:expense_tracker/core/utils/app_colors.dart';
import 'package:expense_tracker/core/extensions/text_extension.dart';
import 'package:expense_tracker/core/constants/svgs_name.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  TransactionType _type = TransactionType.expense;
  int _selectedCategory = 0;
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  AccountType _accountType = AccountType.cash;
  var autoValidateMode = AutovalidateMode.disabled;
  final List<CategoryItemModel> _categories = [
    CategoryItemModel(
      svgName: SvgsName.dollar,
      label: 'Salary',
      bgColor: const Color(0xFFE3F2FD),
      iconColor: const Color(0xFF1976D2),
    ),
    CategoryItemModel(
      svgName: SvgsName.fastFoodOutline,
      label: 'Food',
      bgColor: const Color(0xFFFDECEA),
      iconColor: const Color(0xFFE74C3C),
    ),
    CategoryItemModel(
      svgName: SvgsName.carFront,
      label: 'Transport',
      bgColor: const Color(0xFFFFF3E0),
      iconColor: const Color(0xFFF39C12),
    ),
    CategoryItemModel(
      svgName: SvgsName.shoppingBag,
      label: 'Shopping',
      bgColor: const Color(0xFFFCE4EC),
      iconColor: const Color(0xFFE91E63),
    ),
    CategoryItemModel(
      svgName: SvgsName.bill,
      label: 'Bills',
      bgColor: const Color(0xFFE8EAF6),
      iconColor: const Color(0xFF5C6BC0),
    ),

    CategoryItemModel(
      svgName: SvgsName.heart,
      label: 'Health',
      bgColor: const Color(0xFFFCE4EC),
      iconColor: const Color(0xFFE74C3C),
    ),
    CategoryItemModel(
      svgName: SvgsName.bookHalf,
      label: 'Education',
      bgColor: const Color(0xFFE8F5E9),
      iconColor: const Color(0xFF388E3C),
    ),
    CategoryItemModel(
      svgName: SvgsName.dotsHorizontal,
      label: 'Other',
      bgColor: const Color(0xFFF5F5F5),
      iconColor: const Color(0xFF888888),
    ),
  ];

  @override
  void dispose() {
    _noteController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: BlocConsumer<AddTransactionBloc, AddTransactionState>(
        listener: (context, state) {
          if (state.addTransactionRequest == AddTransactionRequest.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                title: 'Success',
                message: 'Added successfully',
                contentType: ContentType.success,
              ).snackBar,
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              RoutesName.mainLayout,
              (route) => false,
            );
          }
          if (state.addTransactionFailure == AddTransactionRequest.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackBar(
                title: 'Error',
                message: state.addTransactionFailure!.errMessage,
                contentType: ContentType.success,
              ).snackBar,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text('Add Transaction', style: context.titleMedium),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    _buildToggle(),
                    SizedBox(height: 20.h),
                    _buildAmountDisplay(),
                    SizedBox(height: 20.h),
                    Text('Select Category', style: context.labelLarge),
                    SizedBox(height: 12.h),
                    _buildCategories(),
                    SizedBox(height: 20.h),
                    _buildFieldLabel('Date'),
                    SizedBox(height: 6.h),
                    _buildDateField(),
                    SizedBox(height: 14.h),
                    _buildFieldLabel('Account'),
                    SizedBox(height: 6.h),
                    _buildAccountField(),
                    SizedBox(height: 14.h),
                    _buildFieldLabel('Add Note (Optional)'),
                    SizedBox(height: 6.h),
                    _buildNoteField(),
                    SizedBox(height: 28.h),
                    state.addTransactionRequest == AddTransactionRequest.loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.green16A3,
                            ),
                          )
                        : PrimaryButton(
                            text: "Save Transaction",
                            onTap: () {
                              final isValid = formKey.currentState!.validate();

                              if (!isValid) {
                                setState(() {
                                  autoValidateMode =
                                      AutovalidateMode.onUserInteraction;
                                });
                                return;
                              }
                              context.read<AddTransactionBloc>().add(
                                SaveTransactionEvent(
                                  title: _categories[_selectedCategory].label,
                                  amount:
                                      double.tryParse(
                                        _amountController.text.trim(),
                                      ) ??
                                      0.0,
                                  category:
                                      _categories[_selectedCategory].label,
                                  transactionType: _type,
                                  accountType: _accountType,
                                  date: _selectedDate,
                                  note: _noteController.text.trim(),
                                ),
                              );
                            },
                          ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggle() {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Row(
        children: [
          _toggleBtn('Expense', TransactionType.expense, AppColors.redEF44),
          _toggleBtn('Income', TransactionType.income, AppColors.green16A3),
        ],
      ),
    );
  }

  Widget _toggleBtn(String label, TransactionType type, Color activeColor) {
    final isActive = _type == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = type),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: context.bodyMedium.copyWith(
              color: isActive ? Colors.white : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountDisplay() {
    return CustomTextField(
      label: '',
      hintText: '0.00 EG',
      controller: _amountController,
      textAlign: TextAlign.center,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (p0) => AppValidators.amount(p0),
    );
  }

  Widget _buildCategories() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 8.w,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (_, i) => _buildCategoryItem(i),
    );
  }

  Widget _buildCategoryItem(int index) {
    final cat = _categories[index];
    final isSelected = _selectedCategory == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: cat.bgColor,
              borderRadius: BorderRadius.circular(14.r),
              border: isSelected
                  ? Border.all(color: cat.iconColor, width: 2)
                  : null,
            ),
            child: Center(
              child: SvgPicture.asset(
                cat.svgName,
                width: 24.w,
                colorFilter: ColorFilter.mode(cat.iconColor, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            cat.label,
            style: context.bodySmall.copyWith(color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: context.bodyMedium.copyWith(color: Colors.grey[600]),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2025),
          lastDate: DateTime.now(),
        );
        if (picked != null) setState(() => _selectedDate = picked);
      },
      child: _fieldContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_monthName(_selectedDate.month)} ${_selectedDate.day}, ${_selectedDate.year}',
              style: context.bodyMedium,
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 18.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountField() {
    String getAccountName(AccountType type) {
      switch (type) {
        case AccountType.cash:
          return 'Cash';
        case AccountType.bankAccount:
          return 'Bank Account';
        case AccountType.debitCard:
          return 'Debit Card';
      }
    }

    return _fieldContainer(
      child: DropdownButtonHideUnderline(
        child: DropdownButton<AccountType>(
          value: _accountType,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
            size: 20.sp,
          ),
          style: context.bodyMedium,
          items: AccountType.values.map((account) {
            return DropdownMenuItem<AccountType>(
              value: account,
              child: Text(getAccountName(account)),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _accountType = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildNoteField() {
    return _fieldContainer(
      child: TextField(
        controller: _noteController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'e.g. Lunch with friends',
          hintStyle: context.bodyMedium.copyWith(color: Colors.grey[400]),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        style: context.bodyMedium,
        maxLines: 2,
      ),
    );
  }

  Widget _fieldContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: child,
    );
  }

  String _monthName(int month) {
    const months = [
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
    return months[month - 1];
  }
}
