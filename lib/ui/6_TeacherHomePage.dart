import 'package:flutter/material.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:provider/provider.dart';

class TeacherHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);
    return Scaffold (
      appBar: new AppBar(title: Text('Welcome Teacher'),
      actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              tooltip: "Log Out",
              onPressed: () {
                AlertDialog alertDialog = new AlertDialog(
                  title: Text('Are you sure to log out ?'),
                  actions: <Widget>[
                    RaisedButton(
                      child: new Text("Cancel", style: TextStyle(color: Colors.black),),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.green,
                    ),
                    RaisedButton(
                      child: new Text("Log Out", style: TextStyle(color: Colors.black),),
                      color: Colors.red,
                      onPressed: () {
                        adminhomemodel.datauser = '';
                        Navigator.pushReplacementNamed(context, '/');
                      }
                    ),
                  ],
                );
                showDialog(context: context, builder: (_) => alertDialog);
                
              },
            )
          ],
      ),
      
      body: new Container(
        child: new Center(
          child: new Text('Welcome Teacher'),
        ),
      ),
    );
  }
}