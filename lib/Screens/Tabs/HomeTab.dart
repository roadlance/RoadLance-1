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

  Future setCurrentUser() async {
    AuthManager manager = AuthManager();
    User user = await manager.getCurrentUser();
    setState(() {
      currentUser = user;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await setCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return Scaffold(
        backgroundColor: Color(0xFF4b4266),
        appBar: AppBar(
          title: Text("Posts"),
          centerTitle: true,
          backgroundColor: Color(0xFF312c42),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.uid)
              .collection('Posts')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || currentUser == null) {
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
                      mediaUrls: data['Media-Urls'],
                      mediaDetails: data['Media-Details'],
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
    } else {
      return CircularProgressIndicator();
    }
  }
}
