import 'package:flutter/material.dart';
import 'Register.dart';
import '../Components/AuthField.dart';
import '../Database/AuthManager.dart';
import './Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    AuthManager manager = AuthManager();
    Future.delayed(Duration.zero, () async {
      if (await manager.getCurrentUser() != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4b4266),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Karla-Medium',
                    fontSize: 30,
                  ),
                ),
              ),
              AuthField(
                controller: emailController,
                placeholder: 'Email',
                isPassword: false,
              ),
              AuthField(
                controller: passwordController,
                placeholder: 'Password',
                isPassword: true,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: RaisedButton(
                  onPressed: () {
                    AuthManager manager = AuthManager();
                    manager.login(
                        emailController.text, passwordController.text);
                  },
                  color: Color(0xFF8be9fd),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text('Register'),
                ),
              ),
              Text("Don't have an account?"),
              FlatButton(
                child: Text('Register here!'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}