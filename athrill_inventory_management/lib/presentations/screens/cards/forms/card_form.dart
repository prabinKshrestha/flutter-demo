part of 'card_modify_screen.dart';

class CardForm extends StatefulWidget {
  final CardModifyModel cardModifyModel;

  CardForm(this.cardModifyModel);

  @override
  _CardFormState createState() => _CardFormState(this.cardModifyModel);
}

class _CardFormState extends State<CardForm> {
  CardModifyModel cardModifyModel;

  final List<dynamic> monthsCollection = [];
  final List<dynamic> yearsCollection = [];

  final _formKey = GlobalKey<FormState>();
  final _cardHolderFocusNode = FocusNode();
  final _organizationFocusNode = FocusNode();

  _CardFormState(this.cardModifyModel);

  @override
  void initState() {
    super.initState();
    _setMonthsAndYearCollection();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CardBloc, CardState>(
      listener: (_, state) async {
        if (state is CardStateModifySuccess) {
          Navigator.pop(context);
        } else if (state is CardStateModifyError) {
          await showAlertDialog(context, contentText: state.message);
        }
      },
      builder: (_, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              ATTextInput(
                labelText: "Account Number",
                value: this.cardModifyModel.accountNumber,
                maxLength: 16,
                isRequired: true,
                keyboardType: TextInputType.number,
                formatters: [FilteringTextInputFormatter.digitsOnly],
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_cardHolderFocusNode),
                onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(accountNumber: value),
                customValidation: (value) {
                  if (value != null && value.isNotEmpty) {
                    return value.length < 16 ? "Account Number should have exact 16 character." : null;
                  }
                },
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Card Holder Name",
                focusNode: _cardHolderFocusNode,
                value: this.cardModifyModel.cardHolderName,
                maxLength: 100,
                isRequired: true,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_organizationFocusNode),
                onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(cardHolderName: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Organization Name",
                focusNode: _organizationFocusNode,
                value: this.cardModifyModel.organizationName,
                maxLength: 200,
                isRequired: true,
                keyboardType: TextInputType.name,
                onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(organizationName: value),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: ATDropdownInput<int>(
                      labelText: "From Month",
                      value: this.cardModifyModel.fromMonth,
                      data: monthsCollection,
                      displayField: "DisplayName",
                      valueField: "Id",
                      onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(fromMonth: value),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: ATDropdownInput<int>(
                      labelText: "From Year",
                      value: this.cardModifyModel.fromYear,
                      data: yearsCollection,
                      displayField: "DisplayName",
                      valueField: "Id",
                      onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(fromYear: value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: ATDropdownInput<int>(
                      labelText: "To Month",
                      value: this.cardModifyModel.toMonth,
                      data: monthsCollection,
                      displayField: "DisplayName",
                      valueField: "Id",
                      onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(toMonth: value),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: ATDropdownInput<int>(
                      labelText: "To Year",
                      value: this.cardModifyModel.toYear,
                      data: yearsCollection,
                      displayField: "DisplayName",
                      valueField: "Id",
                      onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(toYear: value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ATImageInput(
                labelText: "Image",
                existingNetworkFile: this.cardModifyModel.networkImageName != null ? this.cardModifyModel.networkImage : null,
                onChange: (value) => this.cardModifyModel = this.cardModifyModel.copyWith(imageFile: value, isImageChanged: true),
              ),
              SizedBox(height: 40),
              Container(child: state is CardStateModifyLoading ? ATLoaderWidget() : null),
              SizedBox(height: 20),
              ATSubmitButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<CardBloc>().add(CardEventModifyRequest(cardModifyModel: cardModifyModel));
                  }
                },
                color: AIMColors.secondaryColor,
                disabled: state is CardStateModifyLoading,
              )
            ],
          ),
        );
      },
    );
  }

  _setMonthsAndYearCollection() {
    // todo : For update, add the value of the entity if not exist in collection month and year
    monthsCollection.clear();
    monthsCollection.add({"DisplayName": "None", "Id": 0});
    monthsCollection.addAll(List.generate(12, (index) => {"DisplayName": "${index + 1}", "Id": index + 1}));

    yearsCollection.clear();
    yearsCollection.add({"DisplayName": "None", "Id": 0});
    yearsCollection
        .addAll(List.generate(21, (index) => {"DisplayName": "${DateTime.now().year - 10 + index}", "Id": DateTime.now().year - 10 + index}));
  }
}
