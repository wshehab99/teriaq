import 'package:find_doctor/bloc/app_states.dart';
import 'package:find_doctor/bloc/auth_cubit.dart';
import 'package:find_doctor/screens/Reset_passwod/Forget_Pawword.dart';
import 'package:find_doctor/screens/doctor_screen/doctor_screen.dart';
import 'package:find_doctor/screens/gridpage/gridpage.dart';
import 'package:find_doctor/screens/nurse_location/nurse_location.dart';
import 'package:find_doctor/screens/teriaq_drop_down_menu.dart';
import 'package:find_doctor/shared/glass.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_doctor/screens/signin/continue_with.dart';
import 'package:find_doctor/screens/signup/signup.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../shared/app_CheckBox.dart';
import '../../shared/app_button.dart';
import '../../shared/textFieldApp.dart';

class SignIn extends StatelessWidget {
  SignIn({
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final AppDropDownMenu _role = AppDropDownMenu(
    choices: const ['Doctor', 'Nurse', 'Patient'],
    hint: "Role",
    label: "Role",
  );
  bool differntRole = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(InitialAppState()),
        child: BlocConsumer<AuthCubit, AppStates>(
          listener: ((context, state) {}),
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return Scaffold(
              backgroundColor:
                  (state is ErrorState) ? Colors.grey : Colors.white,
              body: SafeArea(
                  child: (state is LoadingState || state is DoneState)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : (state is ErrorState)
                          ? AlertDialog(
                              title: const Text('Error !'),
                              content: Text(cubit.errorMsg ??
                                  "Something went wrong, please try again later"),
                              actions: [
                                ElevatedButton(
                                    onPressed: cubit.backToNormalState,
                                    child: const Text("back")),
                                ElevatedButton(
                                    onPressed: () {
                                      differntRole = true;
                                      cubit.backToNormalState();
                                    },
                                    child:
                                        const Text("Login with differnt role")),
                              ],
                            )
                          : SingleChildScrollView(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              child: Column(children: [
                                SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.41,
                                  child: GlassMorphism(
                                    // decoration: const BoxDecoration(
                                    //     color: Colors.blueAccent,
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(180)),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //           offset: Offset(0, 5),
                                    //           blurRadius: 10,
                                    //           color: Colors.black54)
                                    //     ]),
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          height: 70,
                                        ),
                                        Image(
                                          image: AssetImage(
                                              'assets/images/dawinyLogoG.png'),
                                          width: 220,
                                          height: 100,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text(
                                          "Sign in to your account",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TeriaqTextField(
                                          label: 'Email',
                                          hint: 'Email',
                                          controller: _email,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                    .hasMatch(value)) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TeriaqTextField(
                                            controller: _password,
                                            label: 'Password',
                                            hint: 'Password',
                                            validator: (value) {
                                              if (value!.isEmpty ||
                                                  value.length < 8) {
                                                return 'please enter a password more than 8 character';
                                              }
                                              return null;
                                            },
                                            hide: true),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        differntRole
                                            ? _role
                                            : const SizedBox(
                                                width: 1,
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CheckBoxRow(
                                          isCheked: cubit.remeberMeValue,
                                          onPress: (value) {
                                            cubit.remeberMe(value!);
                                          },
                                        ),
                                        AppButton(
                                            text: 'Sign in',
                                            bottenColor:
                                                Colors.green.withOpacity(.7),
                                            textColor: Colors.white,
                                            borderradius:
                                                BorderRadius.circular(5),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // doctor at the begning ------ later will be dynamic
                                                await cubit
                                                    .logIn(_email.text,
                                                        _password.text,
                                                        diffRole: differntRole
                                                            ? _role
                                                                .dropdownValue!
                                                                .toLowerCase()
                                                            : null)
                                                    .then((value) {
                                                  if (value == 2) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                GridPage()));
                                                  } else if (value == 3) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                NurseLocation()));
                                                  } else if (value == 1) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Doctor_screen()));
                                                  }
                                                });

                                                // _checkuser(context);
                                              }
                                            }),
                                      ],
                                    )),
                                TextButton(
                                  onPressed: () {},
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPassword()));
                                    },
                                    child: const Text(
                                      'Forget the password?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Or continue with',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black54),
                                ),
                                ContinueWith(
                                    firstElementIcon: Icon(
                                      Icons.facebook,
                                      size: 30,
                                      color: Colors.blue[800],
                                    ),
                                    firstElementText: "Facebook",
                                    secondElementIcon: const Image(
                                      image: AssetImage(
                                          'assets/images/google.jpg'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    secondElementText: "Google"),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Dont have an account?',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return SignUp();
                                          }));
                                        },
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))
                                  ],
                                )
                              ]),
                            )),
            );
          },
        ));
  }

//check if the email and password are in the list
  _checkuser(context) {
    User user = User(
      email: _email.text,
      password: _password.text,
    );
    for (int i = 0; i < User.users.length; i++) {
      if (user.email == User.users[i].email &&
          user.password == User.users[i].password) {
        User.currentUser = User.users[i];
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GridPage()));
        return;
      }
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Sothing wrong')));
  }
}
