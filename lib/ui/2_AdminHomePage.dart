import 'package:flutter/material.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

    return ModalProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Welcome ${adminhomemodel.datauser[0]['username']}'),
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
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/teacheradd'),
        ),
        body: new FutureBuilder<List>(
          future: adminhomemodel.getData(),
          builder: (context, snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
              return Container(
                child: Center(
                  child: new Text(snapshot.error),
                ),
              );
            } else {
              adminhomemodel.user = snapshot.data;
              return  snapshot.hasData 
              ? new ItemList()
              : new Center (child: new  CircularProgressIndicator(),);
            } 
          },
        )
      ),
      inAsyncCall: adminhomemodel.getisLoading,
      opacity: 0.5,
      progressIndicator: CircularProgressIndicator(),
    );
  }
}

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

    return ListView.builder(
      itemCount: adminhomemodel.user==null ? 0  : adminhomemodel.user.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () {
              adminhomemodel.index = i;
              Navigator.pushNamed(context, '/teacherdetails');
            },
            child: new Card(
              child: new ListTile(
                title: new Text(adminhomemodel.user[i]['Teacher_email']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Sekolah : ${adminhomemodel.user[i]['Teacher_sekolah']}"),
              )
            ),
          ),
        );
        },
    );
  }
}