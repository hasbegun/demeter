import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:demeter/components/common/page_header.dart';
import 'package:demeter/components/common/page_heading.dart';
import 'package:demeter/pages/login_page.dart';
import 'package:demeter/components/common/custom_input_field.dart';
import 'package:demeter/components/common/custom_form_button.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailCtl = TextEditingController();
  final _forgetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController emailController= TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    key: _forgetPasswordFormKey,
                    child: Column(children: [
                      const PageHeading(title: 'Forgot password',),
                      CustomInputField(
                        controller: emailController,
                        labelText: 'Email',
                        hintText: 'Your email id',
                        isDense: true,
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
                      const SizedBox(height: 20,),
                      CustomFormButton(innerText: 'Submit', onPressed: _handleForgetPassword,),
                      const SizedBox(height: 20,),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()))
                          },
                          child: const Text(
                            'Back to login',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff939393),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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

  void _handleForgetPassword() {
    // forget password
    if (_forgetPasswordFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Send the password reset link to the email.')),
      );
      if (!context.mounted) return;
      Navigator.of(context).pop();

    }
  }
}
