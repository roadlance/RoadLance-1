import 'package:flutter/material.dart';
import './Tabs/HomeTab.dart';
import './Tabs/PostTab.dart';
import './Tabs/ProfileTab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    this.showWelcomePopup,
  });

  bool showWelcomePopup = false;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showWelcomePopup() {
    String text = '''
We're glad you're onboard with us! Here's how you can get started!

1) Add Your First Post
  -> Upon dismissing this popup, you'll be prompted to choose either video or image
  -> Select the type of media you want to choose
  -> Select the category of the violation using the dropdown
  -> Write a description of the violation
  -> Submit the violation to the traffic police by clicking the button!

Easy isn't it? You can view our top contributors through the leaderboard from Home tab.
View your recent posts from the home tab too!
    ''';

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Text(
          'Welcome To RoadLance!',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Karla-Medium',
            fontSize: 23,
          ),
        ),
      ),
    );
  }

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
