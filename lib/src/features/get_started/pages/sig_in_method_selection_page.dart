import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../user/auth/widgets/custom_sigi_in_button.dart';
import 'package:http/http.dart' as http;

class SigInMethodSelectionPage extends StatefulWidget {
  const SigInMethodSelectionPage({super.key});

  @override
  State<SigInMethodSelectionPage> createState() =>
      _SigInMethodSelectionPageState();
}

class _SigInMethodSelectionPageState extends State<SigInMethodSelectionPage> {
  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Let’s Get Started',
                textAlign: TextAlign.center,
                style: textTheme(context).headlineSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Let’s dive into your account!',
                textAlign: TextAlign.center,
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.8),
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                AppImages.vectorImage,
                height: size.height * 0.3,
                width: size.width * 0.6,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            // CustomSigInButton(
            //   svgIconPath: AppIcons.googleIcon,
            //   text: 'Continue with Google',
            //   onPressed: () async {
            //     showModalBottomSheet(
            //       context: context,
            //       builder: (context) => Container(
            //         height: MediaQuery.of(context).size.height * 0.5,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //             color: colorScheme(context).surface,
            //             borderRadius:
            //                 BorderRadius.vertical(top: Radius.circular(30))),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //           child: Column(
            //             children: [
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               Text(
            //                 'Choose Registeration Type',
            //                 style: textTheme(context).headlineMedium?.copyWith(
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //               ),
            //               SizedBox(
            //                 height: 20,
            //               ),
            //               selectedSignupRoleBottomSheet(
            //                   context: context,
            //                   text: 'User',
            //                   onTap: () {
            //                     StaticData.role = 'user';
            //                     SharedPrefHelper.saveString(roleText, 'user');
            //                   }),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               selectedSignupRoleBottomSheet(
            //                   context: context, text: 'Seller', onTap: () {}),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               selectedSignupRoleBottomSheet(
            //                   context: context,
            //                   text: 'Professional',
            //                   onTap: () async {
            //                     StaticData.role = 'professional';
            //                     SharedPrefHelper.saveString(
            //                         roleText, 'professional');

            //                     bool isSuccess = await authController
            //                         .signInWithGoogle(context, 'professional');

            //                     if (isSuccess) {
            //                       MyAppRouter.clearAndNavigate(
            //                           context, AppRoute.userBottomNavBar);
            //                     } else {
            //                       print("not logged in");
            //                     }
            //                   }),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
            const SizedBox(height: 50),
            if (Platform.isIOS)
              CustomSigInButton(
                svgIconPath: AppIcons.appleIcon,
                text: 'Continue with Apple',
                onPressed: () async {
                  StaticData.role = 'professional';
                  SharedPrefHelper.saveString(roleText, 'professional');

                  bool isSuccess = await authController.signInWithApple(
                      context, 'professional');

                  if (isSuccess) {
                    MyAppRouter.clearAndNavigate(
                        context, AppRoute.userBottomNavBar);
                  } else {
                    print("not logged in");
                  }
                },
              ),
            const SizedBox(height: 20),
            CustomButton(
              iconColor: colorScheme(context).primary,
              arrowCircleColor: colorScheme(context).surface,
              text: 'Sign up',
              backgroundColor: colorScheme(context).primary,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: colorScheme(context).surface,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Choose Registeration Type',
                            style: textTheme(context).headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          selectedSignupRoleBottomSheet(
                              context: context,
                              text: 'User',
                              onTap: () {
                                StaticData.role = 'user';
                                SharedPrefHelper.saveString(roleText, 'user');
                                context.pushNamed(
                                  AppRoute.signUpPage,
                                  extra: {
                                    "role": "user",
                                  },
                                );
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          // selectedSignupRoleBottomSheet(
                          //     context: context,
                          //     text: 'Seller',
                          //     onTap: () {
                          //       context.pushNamed(AppRoute.sellerSignIn,
                          //           extra: {"role": "seller"});
                          //     }),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          selectedSignupRoleBottomSheet(
                              context: context,
                              text: 'Professional',
                              onTap: () {
                                StaticData.role = 'professional';
                                SharedPrefHelper.saveString(
                                    roleText, 'professional');
                                context.pushNamed(
                                  AppRoute.responsiblesignUpPage,
                                );
                              }),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              boxShadow: [],
              iconColor: colorScheme(context).surface,
              arrowCircleColor: colorScheme(context).primary,
              text: 'Login',
              textColor: colorScheme(context).primary,
              backgroundColor: colorScheme(context).surface,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: colorScheme(context).surface,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Choose Account Type',
                            style: textTheme(context).headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          selectedRoleBottomSheet(
                              context: context,
                              text: 'User',
                              onTap: () {
                                StaticData.role = 'user';
                                SharedPrefHelper.saveString(roleText, 'user');
                                context.pushNamed(
                                  AppRoute.signInPage,
                                  extra: {
                                    "role": "user",
                                  },
                                );
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          selectedRoleBottomSheet(
                              context: context,
                              text: 'Seller',
                              onTap: () {
                                StaticData.role = 'seller';
                                SharedPrefHelper.saveString(roleText, 'seller');
                                context.pushNamed(AppRoute.sellerSignIn,
                                    extra: {"role": "seller"});
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          selectedRoleBottomSheet(
                              context: context,
                              text: 'Responsible',
                              onTap: () {
                                StaticData.role = 'professional';
                                SharedPrefHelper.saveString(
                                    roleText, 'professional');
                                context.pushNamed(
                                  AppRoute.responsiblesignInPage,
                                );
                              }),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: size.height * 0.09,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       showModalBottomSheet(
            //         context: context,
            //         builder: (context) => Container(
            //           height: MediaQuery.of(context).size.height * 0.5,
            //           width: double.infinity,
            //           decoration: BoxDecoration(
            //               color: colorScheme(context).surface,
            //               borderRadius:
            //                   BorderRadius.vertical(top: Radius.circular(30))),
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //             child: Column(
            //               children: [
            //                 SizedBox(
            //                   height: 20,
            //                 ),
            //                 Text(
            //                   'Choose Account Type',
            //                   style:
            //                       textTheme(context).headlineMedium?.copyWith(
            //                             fontWeight: FontWeight.bold,
            //                           ),
            //                 ),
            //                 SizedBox(
            //                   height: 20,
            //                 ),
            //                 selectedRoleBottomSheet(
            //                     context: context,
            //                     text: 'User',
            //                     onTap: () {
            //                       StaticData.role = 'user';
            //                       SharedPrefHelper.saveString(roleText, 'user');
            //                       context.pushNamed(
            //                         AppRoute.signInPage,
            //                         extra: {
            //                           "role": "user",
            //                         },
            //                       );
            //                     }),
            //                 SizedBox(
            //                   height: 15,
            //                 ),
            //                 selectedRoleBottomSheet(
            //                     context: context,
            //                     text: 'Seller',
            //                     onTap: () {
            //                       StaticData.role = 'seller';
            //                       SharedPrefHelper.saveString(
            //                           roleText, 'seller');
            //                       context.pushNamed(AppRoute.sellerSignIn,
            //                           extra: {"role": "seller"});
            //                     }),
            //                 SizedBox(
            //                   height: 15,
            //                 ),
            //                 selectedRoleBottomSheet(
            //                     context: context,
            //                     text: 'Responsible',
            //                     onTap: () {
            //                       StaticData.role = 'professional';
            //                       SharedPrefHelper.saveString(
            //                           roleText, 'professional');
            //                       context.pushNamed(
            //                         AppRoute.responsiblesignInPage,
            //                       );
            //                     }),
            //                 SizedBox(
            //                   height: 15,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: colorScheme(context).surface,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide(color: colorScheme(context).primary),
            //         borderRadius: BorderRadius.circular(30.0),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const SizedBox(width: 40),
            //         Text(
            //           'Login',
            //           style: textTheme(context).titleMedium?.copyWith(
            //               color: colorScheme(context).primary,
            //               fontWeight: FontWeight.w600),
            //         ),
            //         CircleAvatar(
            //           radius: 23,
            //           backgroundColor: colorScheme(context).primary,
            //           child: Icon(
            //             Icons.arrow_forward,
            //             color: colorScheme(context).surface,
            //             size: 24.0,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget selectedRoleBottomSheet(
      {required BuildContext context,
      required String text,
      required void Function()? onTap}) {
    return CustomContainer(
      onTap: onTap,
      borderRadius: 15,
      padding: EdgeInsets.symmetric(vertical: 20),
      color: colorScheme(context).surface,
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 25,
            color: colorScheme(context).onSurface.withOpacity(0.1))
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Text(
              text,
              style: textTheme(context)
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: colorScheme(context).onSurface.withOpacity(.4),
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget selectedSignupRoleBottomSheet(
      {required BuildContext context,
      required String text,
      required void Function()? onTap}) {
    return CustomContainer(
      onTap: onTap,
      borderRadius: 15,
      padding: EdgeInsets.symmetric(vertical: 20),
      color: colorScheme(context).surface,
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 25,
            color: colorScheme(context).onSurface.withOpacity(0.1))
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Text(
              text,
              style: textTheme(context)
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: colorScheme(context).onSurface.withOpacity(.4),
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}

class GoogleSignInPage extends StatefulWidget {
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  bool _loading = false;
  String? _tokenResponse;
  String? _error;

  Future<void> _signInWithGoogle() async {
    setState(() {
      _loading = true;
      _tokenResponse = null;
      _error = null;
    });

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        setState(() {
          _loading = false;
          _error = 'Sign in aborted by user';
        });
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final String? idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        throw Exception('Failed to get ID token.');
      }

      // Make POST request
      final response = await http.post(
        Uri.parse('https://copcup.miftatech.com/api/firebase-login'),
        headers: {
          'Accept': 'application/json',
          'Accept-Language': 'fr',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id_token': idToken,
          'role': 'user',
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _tokenResponse = response.body;
        });
      } else {
        throw Exception(
            'Server responded with status: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Sign-In")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: _loading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: _signInWithGoogle,
                      child: const Text("Sign In with Google"),
                    ),
                    const SizedBox(height: 20),
                    if (_tokenResponse != null)
                      Text("Response:\n$_tokenResponse"),
                    if (_error != null)
                      Text("Error:\n$_error",
                          style: TextStyle(color: Colors.red)),
                  ],
                ),
        ),
      ),
    );
  }
}
