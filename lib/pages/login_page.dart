import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:demeter/components/common/custom_form_button.dart';
import 'package:demeter/components/common/custom_input_field.dart';
import 'package:demeter/components/common/page_header.dart';
import 'package:demeter/components/common/page_heading.dart';
import 'package:demeter/services/auth_services.dart';
import 'package:demeter/utils/helper_functions.dart';
import 'package:demeter/pages/forget_password_page.dart';
import 'package:demeter/pages/profile_page.dart';
import 'home_page.dart';
import 'package:demeter/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwdController= TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'Log-in',),
                        CustomInputField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Your email id',
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Email is required!';
                            }
                            if(!EmailValidator.validate(textValue)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          }
                        ),
                        const SizedBox(height: 16,),
                        CustomInputField(
                          controller: passwdController,
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if(textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16,),
                        Container(
                          width: size.width * 0.80,
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordPage()))
                            },
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: Color(0xff939393),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        CustomFormButton(innerText: 'Login',
                          onPressed: _handleLoginUser,),
                        const SizedBox(height: 18,),
                        SizedBox(
                          width: size.width * 0.8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()))
                                },
                                child: const Text('Sign-up', style: TextStyle(fontSize: 15, color: Color(0xff748288), fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoginUser() async {
    // login user
    if (_loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Query user data...')),
      );

      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator(),);
      });

      try {
        final user = await FireAuth().signInUsingEmailPassword(email: emailController.text, password: passwdController.text);
        if (user != null) {
          if (!context.mounted) return;
          Navigator.of(context).pop();
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context)=>HomePage()));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>HomePage()));
            // MaterialPageRoute(builder: (context)=>ProfilePage(user: userCredential.user)));
        }
      } on FirebaseAuthException catch(e) {
        if (!context.mounted) return;
        Navigator.of(context).pop();
        switch(e.code) {
          case 'user-not-found':
          case 'wrong-password':
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                const CustomDialog(message: 'You may have entered the wrong email address or password or your account might be locked.'),
            );
            break;
          case 'too-many-requests':
            showDialog(
              context: context,
              builder: (BuildContext context) =>
              const CustomDialog(message: 'Too many requests. Please slow down.'),
            );
            break;
          default:
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                CustomDialog(message: 'Unhandled error ${e.message.toString()}'),
            );
        }
      }
    }
  }
}
