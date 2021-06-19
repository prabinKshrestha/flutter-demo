part of '../login_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  AuthRequestModel requestModel = AuthRequestModel(username: "", password: "");

  @override
  Widget build(BuildContext context) {
    bool _isObscured = true;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) {
        if (state is LoginStateInitial) {
          _isObscured = state.isPasswordHidden;
        }
        return Form(
          key: _formKey,
          child: Column(
            children: [
              FormFieldContainer(
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 15, letterSpacing: 1),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: AIMColors.secondaryColor),
                    border: InputBorder.none,
                    hintText: "Username",
                  ),
                  onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                  onChanged: (value) => requestModel = requestModel.copyWith(username: value),
                ),
              ),
              SizedBox(height: 20),
              FormFieldContainer(
                child: TextFormField(
                  focusNode: _passwordFocusNode,
                  obscureText: _isObscured,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(fontSize: 15, letterSpacing: 1),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: AIMColors.secondaryColor),
                    suffixIcon: GestureDetector(
                      onTap: () => context.read<LoginBloc>().add(LoginEventPasswordObscured(isObscured: !_isObscured)),
                      child: Icon(_isObscured ? Icons.visibility : Icons.visibility_off, color: AIMColors.secondaryColor),
                    ),
                    border: InputBorder.none,
                    hintText: "Password",
                  ),
                  onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                  onChanged: (value) => requestModel = requestModel.copyWith(password: value),
                ),
              ),
              Builder(builder: (_) {
                if (state is LoginStateFailure) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        // todo : extract this error color code to constant color
                        Text(state.errorMessage, style: TextStyle(fontSize: 12, color: Colors.red)),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(height: 40);
                }
              }),
              GestureDetector(
                onTap: () {
                  if (state is! LoginStateLoading) {
                    FocusScope.of(context).unfocus();
                    context.read<LoginBloc>().add(LoginEventRequest(requestModel.username, requestModel.password));
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: state is LoginStateLoading ? AIMColors.secondaryColor.withOpacity(0.5) : AIMColors.secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    state is LoginStateLoading ? "Signing In" : "Sign In",
                    style: TextStyle(fontSize: 18, letterSpacing: 1, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
