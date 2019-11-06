import 'package:flutter/material.dart';
import 'package:mysqlcrudnlogin/main.dart';
import 'package:mysqlcrudnlogin/model/getLogin.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mysqlcrudnlogin/statefulwrapper.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);

    return StatefulWrapper(
      onInit: () => adminhomemodel.checkInternetConnectivity(context),
        child: ModalProgressHUD(
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
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route)=>false);
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
            backgroundColor: Colors.purple,
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
                : new Center (child: new  CircularProgressIndicator(backgroundColor: Colors.purple),);
              } 
            },
          )
        ),
        inAsyncCall: adminhomemodel.getisLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(backgroundColor: Colors.purple),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController animationControllerparent;

   @override
  void initState() {
    animationControllerparent = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    animationControllerparent..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationControllerparent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationControllerparent,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animationControllerparent,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 40 * (1.0 - animationControllerparent.value), 0.0),
            child: listview(context),
          ),
        );
      },
    );


  }

  Widget listview(BuildContext context) {
    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);
    return ListView.builder(
      itemCount: adminhomemodel.user==null ? 0  : adminhomemodel.user.length,
      itemBuilder: (context, i){
        var count = adminhomemodel.user.length > 10 ? 10 : adminhomemodel.user.length;
          var animation = Tween(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: animationControllerparent, curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn)));
          animationControllerparent.forward();
        return listt(context, i, animation);
        },
    );
  }

  Widget listt(BuildContext context, i, animation) {
    var adminhomemodel = Provider.of<GetAdminHomeModel>(context);
    return AnimatedBuilder(
      animation: animationControllerparent,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: new Container(
              padding: const EdgeInsets.all(10.0),
              child: new GestureDetector(
                onTap: () {
                  adminhomemodel.index = i;
                  Navigator.pushNamed(context, '/teacherdetails');
                },
                child: new Card(
                  child: new ListTile(
                    title: new Text(adminhomemodel.user[i]['Teacher_email']),
                    leading: adminhomemodel.user[i]['image'] != ""
                    ? new Image.network(phone + '/uploads/'+adminhomemodel.user[i]['image'],width: 50, height: 50) 
                    : new Container(width: 50, height: 50, child: Icon(Icons.widgets),),
                    subtitle: new Text("Sekolah : ${adminhomemodel.user[i]['Teacher_sekolah']}"),
                  )
                ),
              ),
            )
          ),
        );
      },
    );
  }
}