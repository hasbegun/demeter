import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demeter/components/common/custom_divider.dart';
import 'package:demeter/components/common/custom_form_button.dart';
import 'package:demeter/components/common/custom_input_field.dart';
import 'package:demeter/components/common/page_heading.dart';
import 'package:demeter/components/common/dropdown_button.dart';
import 'package:demeter/services/auth_services.dart';
import 'package:demeter/utils/helper_functions.dart';
import 'login_page.dart';
import 'profile_page.dart';

// TODO: enable the import MOB-10
// import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // TODO: enable this line MOB-10
  // File? _profileImage;

  final _signupFormKey = GlobalKey<FormState>();
  final TextEditingController nameController= TextEditingController();
  final TextEditingController contactController= TextEditingController();
  final TextEditingController emailController= TextEditingController();
  final TextEditingController passwdController= TextEditingController();
  final TextEditingController confirmPasswdController= TextEditingController();

  // TODO: Enable this section with MOB-10
  // Future _pickProfileImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image == null) return;
  //
  //     final imageTemporary = File(image.path);
  //     setState(() => _profileImage = imageTemporary);
  //   } on PlatformException catch (e) {
  //     debugPrint('Failed to pick image error: $e');
  //   }
  // }

  @override
  void dispose() {
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwdController.dispose();
    confirmPasswdController.dispose();
    super.dispose();
  }

  Widget inputFields() {
    return Column(
      children: [
        const SizedBox(height: 16,),
        CustomInputField(
          controller: nameController,
          labelText: 'Name',
          hintText: 'Your name',
          isDense: true,
          validator: (textValue) {
            if(textValue == null || textValue.isEmpty) {
              return 'Name field is required!';
            }
            return null;
          }
        ),
        const SizedBox(height: 16,),
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
        const SizedBox(height: 16,),
        CustomInputField(
          controller: contactController,
          labelText: 'Contact no.',
          hintText: 'Your contact number',
          isDense: true,
          validator: (textValue) {
            if(textValue == null || textValue.isEmpty) {
              return 'Contact number is required!';
            }
            return null;
          }
        ),
        const SizedBox(height: 16,),
        CustomInputField(
          controller: passwdController,
          labelText: 'Password',
          hintText: 'Your password',
          isDense: true,
          obscureText: true,
          validator: (textValue) {
            if(textValue == null || textValue.isEmpty) {
              return 'Password is required!';
            } else if(textValue.length < 6) {
              return 'Password must be 6 or longer';
            }
            return null;
          },
          suffixIcon: true,
        ),
        const SizedBox(height: 16,),
        CustomInputField(
          controller: confirmPasswdController,
          labelText: 'Confirm Password',
          hintText: 'Confirm the password',
          isDense: true,
          obscureText: true,
          validator: (textValue) {
            if(textValue == null || textValue.isEmpty) {
              return 'Confirm password is required!';
            } else if(textValue != passwdController.text) {
              return 'The password does not match.';
            }
            return null;
          },
          suffixIcon: true,
        ),
        // role
        // const SizedBox(height: 16,),
        // const CustomDropdownButton(
        //   labelText: 'Role',
        // ),
      ],
    );
  }

  Widget socialMedia() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              try {
                // google sign is static method
                final UserCredential credential =
                  await FireAuth.signInWithGoogle();
              } catch (_) {}
            },
            child: Image.asset('assets/images/google.png'),
          ),

          // TODO: support facebook sign in
          // const SizedBox(width: 24),
          // GestureDetector(
          //   onTap: () async {
          //     final credential = await FireAuth.signInWithFacebook();
          //   },
          //   child: Image.asset('assets/images/facebook.png'),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _signupFormKey,
            child: Column(
              children: [
                // const PageHeader(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: Column(
                    children: [
                      const PageHeading(title: 'Sign-up',),
                      // TODO: JIRA MOB-9. However, this will be enable when it is ready: MOB-10
                      // SizedBox(
                      //   width: 130,
                      //   height: 130,
                      //   child: CircleAvatar(
                      //     backgroundColor: Colors.grey.shade200,
                      //     backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      //     child: Stack(
                      //       children: [
                      //         Positioned(
                      //           bottom: 5,
                      //           right: 5,
                      //           child: GestureDetector(
                      //             onTap: _pickProfileImage,
                      //             child: Container(
                      //               height: 50,
                      //               width: 50,
                      //               decoration: BoxDecoration(
                      //                 color: Colors.blue.shade400,
                      //                 border: Border.all(color: Colors.white, width: 3),
                      //                 borderRadius: BorderRadius.circular(25),
                      //               ),
                      //               child: const Icon(
                      //                 Icons.camera_alt_sharp,
                      //                 color: Colors.white,
                      //                 size: 25,
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 16,),
                      inputFields(),
                      const SizedBox(height: 22,),
                      CustomFormButton(innerText: 'Signup',
                        onPressed: _handleSignupUser,),
                      const SizedBox(height: 22,),
                      const CustomDivider(label: 'continue with'),
                      const SizedBox(height: 22,),
                      socialMedia(),
                      const SizedBox(height: 18,),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Already have an account ? ',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff939393),
                                fontWeight: FontWeight.bold),),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) => const LoginPage()))
                              },
                              child: const Text('Log-in',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff748288),
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignupUser() async {
    // signup user
    if (_signupFormKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator(),);
        });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Register user... please wait')),
      );

      try {
        final User? user = await FireAuth().registerUsingEmailPassword(
            email: emailController.text, password: passwdController.text,
            name: nameController.text, contact: contactController.text);
        if (!context.mounted) return;
        Navigator.of(context).pop();
        if(user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User registered.')),
          );
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProfilePage(user: user)));
        }
      } on FirebaseAuthException catch(e) {
        // debug only
        // print(e.code);
        //////
        if (!context.mounted) return;
        Navigator.of(context).pop();  // pop spin dialog
        switch(e.code) {
          case 'email-already-in-use':
            showDialog(
              context: context,
              builder: (BuildContext context) =>
              const CustomDialog(message: 'The email address is already in used by another account'),
            );
            break;
          case 'password-mismatch':
            showDialog(
              context: context,
              builder: (BuildContext context) =>
              const CustomDialog(message: 'Password does not match.'),
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
