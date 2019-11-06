import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlcrudnlogin/main.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:mysqlcrudnlogin/statefulwrapper.dart';
import 'package:mysqlcrudnlogin/ui/4.1_AddImage.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart'; //untuk delegatingstream
import '4.1_AddImage.dart';
import 'package:path/path.dart'; // untuk basename untuk amik nama file

class TeacherAdd extends StatelessWidget {

  static TextEditingController controllerEmail  = new TextEditingController();
  static TextEditingController controllerPassword  = new TextEditingController();
  static TextEditingController controllerSekolah  = new TextEditingController();

  Future addData() async {
    
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();

    var uri = Uri.parse('$phone/adddata.php');

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("imageDB", stream, length, filename: basename(image.path));
    request.fields['email'] = controllerEmail.text;
    request.fields['password'] = controllerPassword.text;
    request.fields['sekolah'] = controllerSekolah.text;
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Print Succeed");
    } else {
      print("Print Failed");
    }

    return true;

  // var url = '$phone/adddata.php';
  // //email tu kena sama dgn php argument
  //   http.post(url, body: {
  //     "email": controllerEmail.text, 
  //     "password": controllerPassword.text,
  //     "sekolah": controllerSekolah.text
  //   });
  }

  Future upload() async{
    var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var uri = Uri.parse('$phone/uploadimage.php');

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("imageDB", stream, length, filename: basename(image.path));

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Print Succeed");
    } else {
      print("Print Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);
    return StatefulWrapper(
      onInit: () => adminhomemodel.checkInternetConnectivity(context),
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Add Teacher'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new TextField(
                    controller: controllerEmail,
                    decoration: new InputDecoration(
                        hintText: "Email Teacher", labelText: "Email Teacher"),
                  ),
                  new TextField(
                    controller: controllerPassword,
                    decoration: new InputDecoration(
                        hintText: "Password Teacher",
                        labelText: "Password Teacher"),
                  ),
                  new TextField(
                    controller: controllerSekolah,
                    decoration: new InputDecoration(
                        hintText: "Sekolah Teacher",
                        labelText: "Sekolah Teacher"),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  UploadImage(imagename: controllerEmail.text,),
                  new RaisedButton(
                    child: new Text("ADD TEACHER"),
                    color: Colors.blueAccent,
                    onPressed: () {
                      // upload();
                      addData().then((value){
                        Navigator.pushNamedAndRemoveUntil(context, '/adminhomepage', (route)=>false);
                      });
                      
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
