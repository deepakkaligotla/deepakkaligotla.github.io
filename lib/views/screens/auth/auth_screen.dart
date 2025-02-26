import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:deepakkaligotla/main.dart';
import 'package:deepakkaligotla/routes/route_delegate.dart';
import 'package:deepakkaligotla/routes/route_handler.dart';
import 'package:deepakkaligotla/providers/model_provider.dart';
import 'package:deepakkaligotla/providers/flutter_secure_storage.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context, listen: false);
    final finalData = Provider.of<LocalStorageProvider>(context, listen: true).localStorage;

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return SignInScreen(
            showPasswordVisibilityToggle: true,
            showAuthActionSwitch: true,
            providers: [
              EmailAuthProvider(),
              PhoneAuthProvider(),
              GoogleProvider(clientId: clientId),
            ],
            actions: [
              AuthStateChangeAction<CredentialReceived>((signInContext, state) async {
                try {
                  await FirebaseAuth.instance.currentUser?.linkWithCredential(state.credential);
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case "providers-already-linked":
                      print("The providers has already been linked to the user.");
                      break;
                    case "invalid-credential":
                      print("The providers's credential is not valid.");
                      break;
                    case "credential-already-in-use":
                      print("The account corresponding to the credential already exists, "
                          "or is already linked to a Firebase User.");
                      break;
                    default:
                      print("Unknown error.");
                  }
                } finally {
                  print("The providers linked to the user.");
                }
              }),
              AuthStateChangeAction<SignedIn>((context, state) async {
                await modelProvider.login(state.user);
                while (!finalData.deviceInfo.isLoggedIn!) {
                  AppRouterDelegate.setPathName(PublicRouteData.restricted.path);
                  await Future.delayed(const Duration(milliseconds: 100));
                }
                AppRouterDelegate.setPathName(PrivateRouteData.privateHome.path);
              })
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/images/flutterfire_300x.png',
                      width: 200, height: 200),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Kaligotla.in, please sign in!')
                    : const Text('Welcome to Kaligotla.in, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        });
  }
}