import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shoppy/core/firebase_options.dart';
import 'package:shoppy/core/routs/routs.dart';
import 'package:shoppy/features/home/presentation/state/bloc/home_bloc.dart';
import 'package:shoppy/features/home/presentation/state/cubit/home_ui_cubit.dart';
import 'package:shoppy/features/login/precentation/bloc/login_bloc.dart';
import 'package:shoppy/features/payment/bloc/payment_bloc.dart';
import 'package:shoppy/features/product_display/presentation/bloc/product_bloc.dart';
import 'package:shoppy/features/sign_up/presentation/bloc/signup_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeUiCubit(),
        ),
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => PaymentBloc(),
        ),
      ],
      child: MaterialApp.router(
          routerConfig: route,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: GoogleFonts.cabin().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          )),
    );
  }
}
