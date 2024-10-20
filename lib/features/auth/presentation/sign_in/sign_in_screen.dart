import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/blocs/auth.dart';
import 'package:retrofit_bloc_go_router_getit/features/auth/presentation/widgets/input_field.dart';
import 'package:retrofit_bloc_go_router_getit/model/forms/sign_in_form/sign_in_form.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with RestorationMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RestorableTextEditingController _usernameController = RestorableTextEditingController();
  final RestorableTextEditingController _passwordController = RestorableTextEditingController();
  bool isObscureText = false;
  bool enabledText=true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Center(
                    child: Text("Welcome Back! \n Login Please",
                      style:TextStyle(
                      fontSize: 20.0),),
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputField(
                      enabled: enabledText,
                      hintText: 'emilys ...',
                      labelText: 'Username',
                      prefixIcon: Icons.email,
                      controller: _usernameController.value,
                      validator: (username) {
                        if (username == null || username.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputField(
                       enabled: enabledText,
                      controller: _passwordController.value,
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icons.password,
                      suffixIcon: !isObscureText ? Icons.visibility : Icons
                          .visibility_off,
                      suffixIconOnPressed: _obscureTextPress,
                      obscureText: isObscureText,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if(state is AuthFailure){
                          return Center(child: Text(state.errorMessage));
                        }
                        if(state is AuthLoading)
                          {
                            return const Center(child:  CircularProgressIndicator());
                          }
                        return ElevatedButton(
                            onPressed: () {
                              if(state is AuthLoading){
                                return;
                              }
                              if (!(_formKey.currentState!.validate())) {
                                return;
                              }
                              final form=SignInForm(username: _usernameController.value.text, password: _passwordController.value.text);
                              context.read<AuthBloc>().add(
                                  AuthLoginRequested(form: form));
                            },
                            child:  Text( state is AuthSuccess ? "Logged in ": "Login"));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _obscureTextPress() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  @override
  String? get restorationId => "login_screen";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_usernameController, "email");
    registerForRestoration(_passwordController, "password");
  }
}

