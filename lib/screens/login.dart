import 'package:cms/screens/signup.dart';
import 'package:cms/widgets/myTextFormField.dart';
import 'package:cms/widgets/mypasswordField.dart';
import 'package:cms/widgets/toptittle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cms/models/user.dart';


import 'home.dart';

class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  static String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static RegExp regExp = new RegExp(p);


  bool isLoading = false;
  UserCredential authResult;
  User_userFromfirebase(authResult){
    return authResult!=null ? UserLog(uid: authResult.user.uid) : null;
  }

  void submit() async{
    setState(() {
      isLoading=true;
    });
    try{
        authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
        User_userFromfirebase(authResult);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePage(uid: authResult.user.uid,)));
    }on PlatformException catch(e){
        String message = "please check internet connection";
        if(e.message!=null){
          message = e.message.toString();
        }
        scaffold.currentState.showSnackBar(SnackBar(content: Text(message),));
        setState(() {
          isLoading=false;
        });
    } catch (e){
      setState(() {
          isLoading=false;
        });
        scaffold.currentState.showSnackBar(SnackBar(content: Text(e.toString()),));
    }
     
     setState(() {
          isLoading=false;
        });
  }

  void validation(){
    if(email.text.isEmpty && password.text.isEmpty){
      scaffold.currentState.showSnackBar(
      SnackBar(
          content: Text("Both fields are Empty"),
        ),
      );
    }
    else if(email.text.isEmpty){
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: Text("Email is Empty"),
        ),
      );
    } else if(password.text.isEmpty){
      scaffold.currentState.showSnackBar(
       SnackBar(
          content: Text("Password is Empty"),
        ),
      );
    } else if(!regExp.hasMatch(email.text)){
      scaffold.currentState.showSnackBar(
       SnackBar(
          content: Text("Email is not Valid"),
        ),
      );
    } else{
      submit();
    }
  }

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: Color(0xfff8f8f8),
      body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical:20,horizontal:20),
          child: Column(
            
            children: [
                TopTitle(
                  substitle: "Welcome Back!",
                  title: "Login"
                ),
                Center(
                  child: Container(
                    height: 300,
                    width: 400,
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyTextFormField(title: "Email",controller: email,),
                        SizedBox(height: 10,),
                        MyPasswordField(title: "Password",controller: password),
                      ],
                    ),
                  ),
                ),
                isLoading==false?Container(
                   height: 60,
                   width: 400,
                   child: RaisedButton(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     color: Theme.of(context).primaryColor,
                     child: Text("Login",
                       style: TextStyle(color: Colors.white, fontSize: 30),
                     ),
                     onPressed: (){
                       validation();
                     },
                   ),
                ):Center(
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't Have Account? ",style: TextStyle(color: Colors.black,fontSize: 18),),
                    GestureDetector(onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>SignUp(),));
                    },
                      child: Text("Sign Up",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),))
                ],    
              )
            ],
          ),
        ),
              ),
      ),
    );
  }
}