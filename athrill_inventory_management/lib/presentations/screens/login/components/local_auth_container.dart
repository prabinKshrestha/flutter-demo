part of '../login_screen.dart';

class LocalAuthContainer extends StatefulWidget {
  @override
  _LocalAuthContainerState createState() => _LocalAuthContainerState();
}

class _LocalAuthContainerState extends State<LocalAuthContainer> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (_, state) {
        return GestureDetector(
          onTap: () async {
            if (state is! LoginStateLoading && await context.read<FirmContextStore>().hasUserContext()) {
              if (await _authenticateUser(_localAuthentication)) {
                FocusScope.of(context).unfocus();
                context.read<LoginBloc>().add(LoginEventRequestWithLocalAuth());
              }
            }
          },
          child: Column(
            children: [
              Icon(Icons.fingerprint, color: AIMColors.primaryColor, size: 50),
              SizedBox(height: 5),
              Text("Sign In with Finger Print", style: TextStyle(fontSize: 14, color: AIMColors.primaryColor, fontWeight: FontWeight.w600)),
            ],
          ),
        );
      },
    );
  }
}
