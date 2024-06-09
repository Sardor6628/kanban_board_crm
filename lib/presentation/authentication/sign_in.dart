import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanban_board/blocks/authentication/auth_bloc.dart';
import 'package:kanban_board/constants/routes.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigating to the dashboard screen if the user is authenticated
          Navigator.of(context).pushReplacementNamed(Routes.dashboardRoute);
        }
        if (state is AuthError) {
          // Showing the error message if the user has entered invalid credentials
          Fluttertoast.showToast(msg: state.message);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is Unauthenticated) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/login.png",
                        width: MediaQuery.of(context).size.width * 0.6,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                                textInputAction: TextInputAction.next,

                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                obscureText: true,
                                textInputAction: TextInputAction.next,

                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? "Enter min. 6 characters"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _authenticateWithEmailAndPassword(
                                          context),
                                  child: const Text('Sign In'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Row(
                          children: const [
                            Expanded(child: Divider(color: Colors.black26, height: 1, thickness: 1,)),
                            Text(" OR ", style: TextStyle(color: Colors.black26),),
                            Expanded(child: Divider(color: Colors.black26, height: 1, thickness: 1,)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),


                      ElevatedButton(
                        onPressed: () => _authenticateWithGoogle(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/logo_g.png",
                                width: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Sign In with Google"),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("No Account?"),
                        TextButton(onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(Routes.signUpRoute);
                        },
                          child: const Text("Sign Up Now"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    ));
  }

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      // If email is valid adding new Event [SignInRequested].
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(
            email: _emailController.text, password: _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
