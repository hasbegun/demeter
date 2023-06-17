import 'package:demeter/components/common/CustomTextDisplay.dart';
import 'package:demeter/components/common/custom_text_display_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/common/custom_form_button.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({Key? key, required this.user}):super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-2.jpeg"),
            fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextDisplayField(
                name: 'Name: ',
                value: (_currentUser.displayName != null) ?
                  _currentUser.displayName.toString() : "Unknown",
              ),
              const SizedBox(height: 16.0),
              CustomTextDisplayField(
                name: 'E-Mail: ',
                value: (_currentUser.email != null) ?
                _currentUser.email.toString() : "Unknown",
              ),
              const SizedBox(height: 16.0),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _currentUser.emailVerified ?
                    const CustomTextDisplay(value: 'Email verified') :
                    const CustomTextDisplay(value: 'Email not verified'),
                )
              ),
              const SizedBox(height: 70.0),
              CustomFormButton(innerText: 'Logout',
                onPressed: _handleLoginUser,),

            ],
          ),
        ),
      ),
    );
  }
  void _handleLoginUser() async {
  }
}