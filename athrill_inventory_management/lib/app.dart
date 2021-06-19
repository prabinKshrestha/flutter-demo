import 'package:aim_business/business.dart';
import 'package:aim_datas/datas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:aim/presentation_constants/presentation_contants_barrel.dart';
import 'package:aim/routers/app_router.dart';

class App extends StatelessWidget {
  final FirmContextStore firmContextStore;
  final UserContextStore userContextStore;
  final FirmRepository firmRepository;
  final FirmAuthenticationRepository firmAuthenticationRepository;
  final TransactionRepository transactionRepository;
  final CardRepository cardRepository;

  const App({
    Key? key,
    required this.firmContextStore,
    required this.userContextStore,
    required this.firmRepository,
    required this.firmAuthenticationRepository,
    required this.transactionRepository,
    required this.cardRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirmContextStore>(create: (_) => firmContextStore),
        RepositoryProvider<FirmAuthenticationRepository>(create: (_) => firmAuthenticationRepository),
        RepositoryProvider<TransactionRepository>(create: (_) => transactionRepository),
        RepositoryProvider<CardRepository>(create: (_) => cardRepository),
        RepositoryProvider<FirmRepository>(create: (_) => firmRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc(userContextStore: userContextStore)),
          BlocProvider<LoginBloc>(
            create: (loginBlocContext) => LoginBloc(
              firmContextStore: firmContextStore,
              authenticationBloc: loginBlocContext.read<AuthenticationBloc>(),
              firmAuthenticationRepository: loginBlocContext.read<FirmAuthenticationRepository>(),
            ),
          ),
          BlocProvider<TransactionBloc>(create: (context) => TransactionBloc(transactionRepository: context.read<TransactionRepository>())),
          BlocProvider<TransactionReportBloc>(
            create: (context) => TransactionReportBloc(transactionRepository: context.read<TransactionRepository>()),
          ),
          BlocProvider<CardBloc>(create: (context) => CardBloc(cardRepository: context.read<CardRepository>())),
        ],
        child: MaterialApp(
          title: 'Athrill Inventory Management',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AIMColors.primaryColor,
            accentColor: AIMColors.secondaryColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              brightness: Brightness.dark,
              backgroundColor: AIMColors.primaryColor,
            ),
          ),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: "/splash",
        ),
      ),
    );
  }
}
