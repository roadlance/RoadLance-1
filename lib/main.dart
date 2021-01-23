import 'package:flutter/material.dart';
import './Screens/Register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RoadLance());
}

class RoadLance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roadlance',
      home: Scaffold(
        body: Register(),
      ),
    );
  }
}
