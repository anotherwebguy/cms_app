import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/screens/home.dart';
import 'package:cms/screens/login.dart';
import 'package:cms/widgets/myTextFormField.dart';
import 'package:cms/widgets/mypasswordField.dart';
import 'package:cms/widgets/toptittle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final TextEditingController email = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController collegeid = TextEditingController();
  bool isAdmin = false;
  final String adminkey = "admin123";
  bool isLoading = false;
  
  static String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static RegExp regExp = new RegExp(p);
  
  
  UserCredential authResult;
  void submit() async{
    setState(() {
      isLoading=true;
    });
    try{
        authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
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
     await FirebaseFirestore.instance.collection("UserData").doc(authResult.user.uid).set({
       "Username":name.text,
       "UserEmail":email.text,
       "UserId":authResult.user.uid,
       "role":isAdmin==false?"Student":"Admin",
       "Idno":collegeid.text,
     });
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Login(),));
     setState(() {
          isLoading=false;
        });
  }
  

  void validation(){
    if(email.text.isEmpty && password.text.isEmpty && collegeid.text.isEmpty){
      scaffold.currentState.showSnackBar(
      SnackBar(
          content: Text("All fields are Empty"),
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
    } else if(isAdmin==true && collegeid.text!=adminkey){
      scaffold.currentState.showSnackBar(
       SnackBar(
          content: Text("You are not authorized to be admin"),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
              child: Container(
          padding: EdgeInsets.symmetric(vertical:20,horizontal:20),
          child: Column(
            children: [
              TopTitle(
                substitle: "Create an Account",
                title: "Sign Up"
              ),
              Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                         MyTextFormField(title: "Enter your Unique College Id no.",
                            controller: collegeid,
                         ),
                         SizedBox(height: 10,),
                         MyTextFormField(title: "Name",
                            controller: name,
                         ),
                         SizedBox(height: 10,),
                         GestureDetector(
                           onTap: (){
                             setState(() {
                               isAdmin=!isAdmin;
                             });
                           },
                           child: Container(
                             height: 60,
                             width: 400,
                             padding: EdgeInsets.only(left:10),
                             alignment: Alignment.centerLeft,
                             child: Text(
                                 isAdmin==false? "Student": "Admin",
                                 style: TextStyle(fontSize: 16,color: Colors.grey),
                             ),
                             decoration: BoxDecoration(color: Color(0xfff5d8e4),
                             borderRadius: BorderRadius.circular(10)),
                           )
                         ),
                         SizedBox(height: 10,),
                         MyTextFormField(title: "Email",
                            controller: email,
                         ),
                         SizedBox(height: 10,),
                         MyPasswordField(title: "Password",
                            controller: password,
                         )
                ],),
              ),
             isLoading==false? Container(
                     height: 60,
                     width: 400,
                     child: RaisedButton(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       color: Theme.of(context).primaryColor,
                       child: Text("Sign Up",
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
                    Text("I already have an account? ",style: TextStyle(color: Colors.black,fontSize: 18),),
                    GestureDetector(onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Login(),));
                    },
                      child: Text("Login",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20),))
                ],    
              )
            ]
          ),
        ),
      ),
    );
  }
}