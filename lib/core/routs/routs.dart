import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppy/features/home/presentation/screens/category_screen.dart';
import 'package:shoppy/features/home/presentation/screens/home_screen.dart';

import 'package:shoppy/features/landing_screen/presentation/screens/landing_screen.dart';
import 'package:shoppy/features/login/precentation/screens/login_screen.dart';
import 'package:shoppy/features/sign_up/presentation/screens/Sign_up_screen.dart';
import 'package:shoppy/features/success_messages/precentation/screens/success_screen.dart';

GoRouter route = GoRouter(
    initialLocation:
        FirebaseAuth.instance.currentUser == null ? "/" : "/homeScreen",
    routes: [
      GoRoute(path: "/", builder: (context, state) => LandingScreen(), routes: [
        GoRoute(
            path: "loginScreen", builder: (context, state) => LoginScreen()),
        GoRoute(
            path: "signupScreen", builder: (context, state) => SignupScreen()),
      ]),
      GoRoute(
          path: "/homeScreen",
          builder: (context, state) => HomeScreen(),
          routes: [
            GoRoute(
                path: "categoryScreen",
                builder: (context, state) {
                  Map _params = state.extra as Map;
                  return CategoryScreen(
                    title: _params["title"],
                  );
                }),
          ]),
      GoRoute(
          path: "/successScreen",
          builder: (context, state) {
            Map params = state.extra as Map<String, dynamic>;

            return SuccessScreen(
              message: params["message"]!,
              nextRout: params["nextRout"]!,
              buttonText: params["buttonText"]!,
            );
          })
    ]);
