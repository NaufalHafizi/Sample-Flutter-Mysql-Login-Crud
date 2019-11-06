import 'package:flutter/material.dart';
import 'package:mysqlcrudnlogin/main.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:mysqlcrudnlogin/statefulwrapper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '5_EditTeacher.dart';

class TeacherDetails extends StatelessWidget {

  void deleteData(BuildContext context) async {

    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

    var url = "$phone/deleteData.php";

    http.post(url, body: {
      'ID': adminhomemodel.user[adminhomemodel.index]['ID']
    });
  }

void confirm(BuildContext context) {

  var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Are you sure want to delete '${adminhomemodel.user[adminhomemodel.index]['Teacher_email']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text('OK DELETE!', style: TextStyle(color: Colors.black),),
        color: Colors.red,
        onPressed: () {
          deleteData(context);
          Navigator.pushNamedAndRemoveUntil(context, '/adminhomepage', (route)=>false);
        },
      ),
      new RaisedButton(
        child: new Text('CANCEL', style: new TextStyle(color: Colors.black),),
        color: Colors.green,
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );

  showDialog(context: context, builder: (_) => alertDialog);
}

  @override
  Widget build(BuildContext context) {

    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

    return StatefulWrapper(
      onInit: () => adminhomemodel.checkInternetConnectivity(context),
      child: new Scaffold (
        appBar: new AppBar(
          title: new Text(adminhomemodel.user[adminhomemodel.index]['Teacher_email']),
        ),
        body: new Container(
          height: 550.0,
          padding: const EdgeInsets.all(20.0),
          child: new Card(
            child: new Center(
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 25,),
                  adminhomemodel.user[adminhomemodel.index]['image'] != ""
                    ? new Image.network(phone + '/uploads/'+adminhomemodel.user[adminhomemodel.index]['image'],width: 250, height: 200)
                    : new Container(width: 200, height: 200, child: Icon(Icons.widgets),),

                  new  Padding(padding: const EdgeInsets.only(top: 30.0),),
                  new Text(adminhomemodel.user[adminhomemodel.index]['Teacher_email'], style: new TextStyle(fontSize: 20),),
                  new Text("Password: ${adminhomemodel.user[adminhomemodel.index]['Teacher_password']}", style: new TextStyle(fontSize: 18),),
                  new Text("Sekolah: ${adminhomemodel.user[adminhomemodel.index]['Teacher_sekolah']}", style: new TextStyle(fontSize: 18),),
                  new  Padding(padding: const EdgeInsets.only(top: 30.0),),

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new RaisedButton(
                        child: new Text('Edit'),
                        color: Colors.green,
                        onPressed:() => Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => EditTeacher(user: adminhomemodel.user, index: adminhomemodel.index,)
                          )
                          )
                      ),
                      new RaisedButton(
                        child: new Text('Delete'),
                        color: Colors.red,
                        onPressed:() => confirm(context),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}