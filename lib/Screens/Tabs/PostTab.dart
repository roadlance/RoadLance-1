import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../Database/DbManager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../../Models/Post.dart';
import '../../Models/Locator.dart';
import '../MediaPlayer.dart';
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
  int images = 0;
  List<File> files = [];
  List<Map> mediaDetails = [];
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
                  onPressed: () async {
                    Navigator.pop(context);
                    File image = await addImage();
                    setState(() {
                      mediaFiles.add(MediaPlayer(
                          image: image,
                          mediaType: 'image',
                          playButtonVisible: false));
                    });
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
                  onPressed: () async {
                    File video = await addVideo();
                    controller = VideoPlayerController.file(video)
                      ..initialize().then((_) {
                        setState(() {
                          mediaFiles.add(MediaPlayer(
                            video: video,
                            controller: controller,
                            mediaType: 'video',
                            playButtonVisible: true,
                          ));
                        });
                      });
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
    DatabaseManager manager = DatabaseManager();
    Timestamp now = Timestamp.now();

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      if (image != null) {
        print("Image successfully picked => $image");
        Locator locator = Locator();
        Position currentPos = await locator.getCurrentPosition();
        setState(() {
          files.add(image);
          images = images + 1;
          mediaDetails.add({
            'Latitude': currentPos.latitude,
            'Longitude': currentPos.longitude,
            'MediaUploadTime': now,
          });
        });
        if (images == 1) {
          manager.createMediaDetails(mediaDetails, now);
        } else {
          manager.updateMediaDetails(mediaDetails, now);
        }
        // get number plate
        String numberPlateRef =
            await manager.getNumberPlate(image, Timestamp.now());

        setState(() {
          numberPlate = numberPlateRef;
        });
      }
    } else {
      print('No image selected.');
    }
    return image;
  }

  Future<File> addVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        video = File(pickedFile.path);
      });
      if (video != null) {
        setState(() {
          files.add(video);
        });
      }
      print('Video successfully picked => $video');
    } else {
      print('No image selected.');
    }
    return video;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4b4266),
      body: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xFF282a36),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DropdownButton<String>(
                    value: violation,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    items: violations
                        .map<DropdownMenuItem<String>>((String value) {
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
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: RaisedButton(
                    onPressed: () {
                      promptInput(context);
                    },
                    color: Color(0xFF8be9fd),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text('Add Image/Video'),
                  ),
                ),
                Column(
                  children: mediaFiles,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: 325,
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
                  onPressed: () async {
                    DatabaseManager manager = DatabaseManager();
                    Locator locator = Locator();
                    Position currentPos = await locator.getCurrentPosition();
                    Timestamp now = Timestamp.now();
                    Post post = Post(
                      violation: violation,
                      description: description,
                      status: 'Unknown',
                      mediaUrls: [],
                      mediaDetails: mediaDetails,
                      numberPlate: numberPlate,
                      latitude: currentPos.latitude,
                      longitude: currentPos.longitude,
                      uploadTime: now,
                    );
                    print("Submit to police");
                    manager.uploadPost(post);
                    manager.uploadFiles(files, now);
                    manager.uploadNumberPlate(numberPlate);
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
      ),
    );
  }
}
