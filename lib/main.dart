import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ImageHolder(),
    );
  }
}

class ImageHolder extends StatefulWidget {
  @override
  _ImageHolderState createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {

  String imageUrl;
  String getUrl = "https://api.unsplash.com/photos/random?client_id=0m8c5Ag56HCcvUnHvBxJF9UpE0GolljQeAHFY7T-q_I";
  void getImage() async {
    var res = await http.get(getUrl);
    if(res.statusCode == 200) {
      var data = jsonDecode(res.body);
      setState(() {
        imageUrl = data["urls"]["small"];
      });
    }
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Images'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              height:400,
              width: 400,
              image: NetworkImage(imageUrl ?? "https://api.unsplash.com/photos/random?client_id=0m8c5Ag56HCcvUnHvBxJF9UpE0GolljQeAHFY7T-q_I"),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              child: Text('Click to get new image'),
              onPressed: () {
                getImage();
              },
            )
          ],
        ),
      ),
    );
  }
}