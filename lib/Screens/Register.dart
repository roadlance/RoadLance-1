import 'package:flutter/material.dart';
import '../Components/AuthField.dart';
import './Login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF4b4266),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Color(0xFFffb86c),
                    fontFamily: 'Karla-Medium',
                    fontSize: 30,
                  ),
                ),
              ),
              AuthField(
                controller: firstNameController,
                placeholder: 'First name..',
                isPassword: false,
              ),
              AuthField(
                controller: firstNameController,
                placeholder: 'Last name..',
                isPassword: false,
              ),
              AuthField(
                controller: firstNameController,
                placeholder: 'Email..',
                isPassword: false,
              ),
              AuthField(
                controller: firstNameController,
                placeholder: 'Phone number..',
                isPassword: false,
              ),
              AuthField(
                controller: firstNameController,
                placeholder: 'Password..',
                isPassword: true,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 25),
                child: SizedBox(
                  width: 125,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Color(0xFF8be9fd),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text('Register'),
                  ),
                ),
              ),
              Text(
                'Already have an account?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                  child: Text(
                    'Login here!',
                    style: TextStyle(
                      color: Color(0xFF50fa7b),
                    ),
                  ),
                  onTap: () {
                    print("Going to Login screen");
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
