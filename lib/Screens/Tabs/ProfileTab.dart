import 'package:flutter/material.dart';
import '../../Database/AuthManager.dart';
import '../../Database/DbManager.dart';
import '../Login.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int currentBalance = 0;

  @override
  void initState() {
    super.initState();
    setCurrentBalance();
  }

  void setCurrentBalance() async {
    DatabaseManager manager = DatabaseManager();
    int updatedBalance = await manager.getUserBalance();
    setState(() {
      currentBalance = updatedBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4b4266),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Current Balance : $currentBalance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            FlatButton.icon(
              onPressed: () async {
                AuthManager manager = AuthManager();
                await manager.signOut().then(
                  (_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.amber,
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
