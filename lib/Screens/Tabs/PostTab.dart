import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class PostTab extends StatefulWidget {
  @override
  _PostTabState createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  String violation = 'Traffic Signal Violation';
  List<String> violations = [
    'Traffic Signal Violation',
    'Parking At No Parking Zone',
    'Bike Driving Without Helmet',
    'Speed Limit Violation',
    'Driving At Wrong Side Of Road',
    'Rash Driving',
    'Accidents',
    'Driving Vehicle Without License Plate',
  ];
  List<Widget> mediaFiles = [];
  String numberPlate = 'Scanning number plates..';
  String description = '';
  String errorMessage = '';
  bool errorVisible = false;
  bool numberPlateVisible = false;
  final picker = ImagePicker();
  File image;
  File video;
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      promptInput(context);
    });
  }

  void promptInput(BuildContext context) {
    showDialog(
      context: context,
      child: Dialog(
        child: SizedBox(
          width: 100,
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 125,
                width: 300,
                child: FlatButton.icon(
                  color: Colors.black,
                  onPressed: () {
                    addImage();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 125,
                width: 300,
                child: FlatButton.icon(
                  color: Colors.green,
                  onPressed: () {
                    addVideo();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.video_call_rounded,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Video',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> addImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        if (image != null) {
          print("Image successfully picked => $image");
        }
      } else {
        print('No image selected.');
      }
    });
  }

  Future<File> addVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        video = File(pickedFile.path);
        print('Video successfully picked => $video');
      } else {
        print('No image selected.');
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4b4266),
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF282a36),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // violation
              DropdownButton<String>(
                value: violation,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items: violations.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Color(0xFF8be9fd),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    violation = newValue;
                  });
                },
              ),
              RaisedButton(
                onPressed: () {
                  promptInput(context);
                },
                color: Color(0xFF8be9fd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('Add Image/Video'),
              ),
              Column(
                children: mediaFiles,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Number Plate: ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xFF282a36),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        numberPlate,
                        style: TextStyle(
                          color: Color(0xFF50fa7b),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 325,
                // height: 40,
                child: TextField(
                  maxLines: null,
                  textAlign: TextAlign.left,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Karla-Medium',
                  ),
                  onChanged: (String text) {
                    print("Description is $text");
                    description = text;
                  },
                  cursorColor: Color(0xFF50fa7b),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    hintText: 'Description..',
                    hintStyle: TextStyle(
                      fontFamily: 'Karla-Medium',
                      color: Colors.grey,
                    ),
                    fillColor: Color(0xFF4b4266),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF50fa7b),
                        width: 3.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF50fa7b),
                        width: 3.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF50fa7b),
                        width: 3.5,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: errorVisible,
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: Color(0xFFff5555),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  print("Submit to police");
                },
                color: Color(0xFF8be9fd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('Submit to Police'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
