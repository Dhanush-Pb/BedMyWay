// ignore_for_file: use_build_context_synchronously

import 'package:bedmyway/Model/google_sing.dart';
import 'package:bedmyway/controller/bloc/auth_bloc.dart';
import 'package:bedmyway/controller/fetchbloc/bloc/hoteldata_bloc.dart';
import 'package:bedmyway/repositories/colors/colors.dart';
import 'package:bedmyway/repositories/components/Bottm_page.dart';
import 'package:bedmyway/repositories/components/snackbar.dart';
import 'package:bedmyway/repositories/custom/page_transition.dart';
import 'package:bedmyway/view/login/sing_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logingpage extends StatefulWidget {
  const Logingpage({Key? key}) : super(key: key);

  @override
  State<Logingpage> createState() => _LogingpageState();
}

class _LogingpageState extends State<Logingpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _isSnackbarShown = false;
  @override
  void dispose() {
    _emailController.text;
    _passwordController.text;

    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<HoteldataBloc>(context).add(FetchdataEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context)
                .pushReplacement(FadePageRoute(page: const NavigationMenu()));
          });
        } else if (state is Authloadin) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthenticateError) {}
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/Screenshot 2024-05-06 212614.png',
                width: 120,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Appcolor.white,
                        prefixIcon: const Icon(Icons.mail_outline_outlined),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        errorText: _emailError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        fillColor: Appcolor.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.visibility_off),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        errorText: _passwordError,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          // Attempt to sign in with Firebase
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                            // If successful, navigate to next screen
                            BlocProvider.of<AuthBloc>(context).add(
                              Loginevent(email: email, password: password),
                            );
                          } catch (e) {
                            // Handle sign-in errors (e.g., wrong password, invalid email)

                            snackbar.showErrorMessageSnackBar(
                                context, 'Invalid email or password');
                          }
                        }
                      },
                      child: Container(
                        height: 45,
                        width: screenWidth - 45,
                        decoration: BoxDecoration(
                          color: Appcolor.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Appcolor.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 8, right: 8, left: 22),
                            child: Divider(),
                          ),
                        ),
                        Text('OR'),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 8, right: 22, left: 8),
                            child: Divider(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: () {
                        signInWithGoogle(context);
                        BlocProvider.of<AuthBloc>(context)
                            .add(GoogleSignInEvent());
                      },
                      child: Container(
                        height: 45,
                        width: screenWidth - 45,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                'assets/images/google.png',
                                width: 25,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                'Continue With Google',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(FadePageRoute(page: SignupPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(' Do you have an account?'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sing up',
                            style: TextStyle(color: Appcolor.blue),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
