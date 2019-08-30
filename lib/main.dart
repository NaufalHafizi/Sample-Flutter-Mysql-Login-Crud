import 'package:flutter/material.dart';
import 'package:mysqlcrudnlogin/ui/1_Loginpage.dart';
import 'package:mysqlcrudnlogin/ui/2_AdminHomePage.dart';
import 'package:mysqlcrudnlogin/ui/3_AdminHomePage.dart';
import 'package:mysqlcrudnlogin/ui/4_Addteacher.dart';
import 'package:mysqlcrudnlogin/ui/6_TeacherHomePage.dart';
import 'package:provider/provider.dart';
import 'model/getLogin.dart';

//String phone = 'http://192.168.43.58';
//String phone = 'http://10.0.2.2';
String phone = 'https://www.naufalhafizi.my/ihadir';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GetAdminHomeModel()),
      ],
      child: new MaterialApp(
        theme:
        //ThemeData(primaryColor: Colors.blueGrey, accentColor: Colors.blueAccent),
        ThemeData(primaryColor: Colors.red, accentColor: Colors.blueAccent),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginPage(),
          '/adminhomepage': (context) => AdminHomePage(),
          '/teacherdetails': (context) => TeacherDetails(),
          '/teacheradd': (context) => TeacherAdd(),
          '/teacherhomepage': (context) => TeacherHomePage(),
        }
      ),
    )
  );
}