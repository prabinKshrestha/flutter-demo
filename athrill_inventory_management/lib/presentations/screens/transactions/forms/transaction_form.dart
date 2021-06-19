part of 'transaction_modify_screen.dart';

class TransactionForm extends StatefulWidget {
  final TransactionModifyModel transactionModifyModel;

  TransactionForm(this.transactionModifyModel);

  @override
  _TransactionFormState createState() => _TransactionFormState(this.transactionModifyModel);
}

class _TransactionFormState extends State<TransactionForm> {
  TransactionModifyModel transactionModifyModel;
  final _formKey = GlobalKey<FormState>();
  final _shortDescriptionFocusNode = FocusNode();

  static const TRANSACTION_TYPES = [
    {"Id": TransactionType.INCOME, "DisplayName": "Income"},
    {"Id": TransactionType.EXPENSES, "DisplayName": "Expenses"}
  ];

  _TransactionFormState(this.transactionModifyModel);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (_, state) async {
        if (state is TransactionStateModifySuccess) {
          Navigator.pop(context);
        } else if (state is TransactionStateModifyError) {
          await showAlertDialog(context, contentText: state.message);
        }
      },
      builder: (_, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              ATNumberInput(
                labelText: "Amount",
                value: this.transactionModifyModel.amount,
                isRequired: true,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_shortDescriptionFocusNode),
                onChange: (value) => this.transactionModifyModel = this.transactionModifyModel.copyWith(amount: value),
                customValidation: (value) {
                  if (value != null && value <= 0) {
                    return "Amount should be more than 0";
                  }
                },
              ),
              SizedBox(height: 20),
              ATDropdownInput<int>(
                labelText: "Transaction Type",
                value: this.transactionModifyModel.transactionTypeId,
                data: TRANSACTION_TYPES,
                displayField: "DisplayName",
                valueField: "Id",
                isRequired: true,
                onChange: (value) => this.transactionModifyModel = this.transactionModifyModel.copyWith(transactionTypeId: value),
              ),
              SizedBox(height: 20),
              ATTextInput(
                labelText: "Description",
                focusNode: _shortDescriptionFocusNode,
                value: this.transactionModifyModel.shortDescription,
                isRequired: true,
                keyboardType: TextInputType.multiline,
                minLines: null,
                maxLines: 5,
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                onChange: (value) => this.transactionModifyModel = this.transactionModifyModel.copyWith(shortDescription: value),
              ),
              SizedBox(height: 40),
              Container(child: state is TransactionStateModifyLoading ? ATLoaderWidget() : null),
              SizedBox(height: 20),
              ATSubmitButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<TransactionBloc>().add(TransactionEventModifyRequest(transactionModifyModel: transactionModifyModel));
                  }
                },
                color: AIMColors.secondaryColor,
                disabled: state is TransactionStateModifyLoading,
              ),
            ],
          ),
        );
      },
    );
  }
}
