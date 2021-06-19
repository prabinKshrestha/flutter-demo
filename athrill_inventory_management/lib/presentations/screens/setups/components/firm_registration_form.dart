part of '../firm_registration_screen.dart';

class FirmRegistrationForm extends StatefulWidget {
  @override
  _FirmRegistrationFormState createState() => _FirmRegistrationFormState();
}

class _FirmRegistrationFormState extends State<FirmRegistrationForm> {
  FirmRegistrationModel firmRegistrationModel = new FirmRegistrationModel(
    firmName: "",
    firstName: "",
    middleName: "",
    lastName: "",
    email: "",
    phoneNumber: "",
    address: "",
    userName: "",
    password: "",
    imageFile: null,
  );

  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _middleNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FirmRegisterBloc, FirmRegisterState>(
      listener: (_, state) async {
        if (state is FirmRegisterStateSuccess) {
          Future.delayed(
            Duration(milliseconds: 1),
            () => Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false),
          );
        } else if (state is FirmRegisterStateError) {
          await showAlertDialog(context, contentText: state.message);
        }
      },
      builder: (_, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              ATTextInput(
                labelText: "Firm Name",
                value: this.firmRegistrationModel.firmName,
                maxLength: 50,
                isRequired: true,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_firstNameFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(firmName: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "First Name",
                focusNode: _firstNameFocusNode,
                value: this.firmRegistrationModel.firstName,
                maxLength: 50,
                isRequired: true,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_middleNameFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(firstName: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Middle Name",
                focusNode: _middleNameFocusNode,
                value: this.firmRegistrationModel.middleName,
                maxLength: 50,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_lastNameFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(middleName: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Last Name",
                focusNode: _lastNameFocusNode,
                value: this.firmRegistrationModel.lastName,
                maxLength: 50,
                isRequired: true,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_emailFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(lastName: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                //todo Validate Email
                labelText: "Email",
                focusNode: _emailFocusNode,
                value: this.firmRegistrationModel.email,
                maxLength: 100,
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_phoneNumberFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(email: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Phone Number",
                focusNode: _phoneNumberFocusNode,
                value: this.firmRegistrationModel.phoneNumber,
                maxLength: 50,
                isRequired: true,
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_userNameFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(phoneNumber: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Username",
                focusNode: _userNameFocusNode,
                value: this.firmRegistrationModel.userName,
                maxLength: 50,
                isRequired: true,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(userName: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Password",
                focusNode: _passwordFocusNode,
                value: this.firmRegistrationModel.password,
                maxLength: 50,
                isRequired: true,
                keyboardType: TextInputType.visiblePassword,
                onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_addressFocusNode),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(password: value),
              ),
              SizedBox(height: 5),
              ATTextInput(
                labelText: "Address",
                focusNode: _addressFocusNode,
                value: this.firmRegistrationModel.address,
                minLines: null,
                maxLines: 5,
                maxLength: 600,
                isRequired: true,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(address: value),
              ),
              SizedBox(height: 30),
              ATImageInput(
                labelText: "Image",
                isRequired: true,
                existingNetworkFile: null,
                onChange: (value) => this.firmRegistrationModel = this.firmRegistrationModel.copyWith(imageFile: value),
              ),
              SizedBox(height: 40),
              Container(child: state is FirmRegisterStateLoading ? ATLoaderWidget() : null),
              SizedBox(height: 20),
              ATSubmitButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<FirmRegisterBloc>().add(FirmRegisterEventRequest(firmRegistrationModel: this.firmRegistrationModel));
                  }
                },
                color: AIMColors.secondaryColor,
                disabled: state is FirmRegisterStateLoading,
              )
            ],
          ),
        );
      },
    );
  }
}
