import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart'; //resize image
import 'package:image/image.dart' as Img; //resize image
import 'dart:math' as Math;

  File image;


class UploadImage extends StatefulWidget {

  final String imagename;

  UploadImage({this.imagename});

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {


  //tanpa resize
  // Future getImageGallery() async{
  //   var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     image = imageFile;
  //   });
  // }

    Future getImageGallery() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image images = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(images,width: 500);

    var compressImg = new File("$path/image_$rand.jpg")
    ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      image = compressImg;
    });
  }

  Future getImageCamera() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = new Math.Random().nextInt(100000);

    Img.Image images = Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(images,width: 500);

    var compressImg = new File("$path/image_$rand.jpg")
    ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      image = compressImg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: image == null
          ? new Text('No image Selected!')
          : new Container(
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.6, 
              child:  Image.file(image,)
            ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.image),
              onPressed: getImageGallery,
            ),
            RaisedButton(
              child: Icon(Icons.camera),
              onPressed: getImageCamera,
            ),
          ],
        )
      ],
    );
  }
}