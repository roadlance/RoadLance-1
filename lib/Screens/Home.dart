import 'package:flutter/material.dart';
import './Tabs/HomeTab.dart';
import './Tabs/PostTab.dart';
import './Tabs/ProfileTab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  Widget tab;

  @override
  void initState() {
    super.initState();
    setState(() {
      tab = PostTab();
    });
  }

  void onItemTapped(int index) {
    print("New index is $index");
    setState(() {
      _selectedIndex = index;
    });
    setState(() {
      switch (_selectedIndex) {
        case 0:
          tab = PostTab();
          break;
        case 1:
          tab = HomeTab();
          break;
        case 2:
          tab = ProfileTab();
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tab,
      backgroundColor: Color(0xFF4b4266),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF282a36),
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
