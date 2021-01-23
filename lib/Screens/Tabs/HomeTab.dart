import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Components/PostCard.dart';
import '../../Models/Post.dart';
import '../../Database/AuthManager.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  User currentUser;

  void setCurrentUser() async {
    AuthManager manager = AuthManager();
    User user = await manager.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .collection('Posts')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map((
                QueryDocumentSnapshot document,
              ) {
                var data = document.data();
                return PostCard(
                  post: Post(
                    violation: data['Violation'],
                    description: data['Description'],
                    status: data['Status'],
                    mediaUrls: data['MediaUrls'],
                    mediaDetails: data['MediaDetails'],
                    numberPlate: data['NumberPlate'],
                    latitude: data['Latitude'],
                    longitude: data['Longitude'],
                    uploadTime: data['UploadTime'],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
