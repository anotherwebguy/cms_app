import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title;
  final String substitle;
  TopTitle({this.substitle,this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
                    height: 150,
                    width: 400,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,style: TextStyle(fontSize: 40,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold)),
                        Text(substitle,style: TextStyle(fontSize: 30,color: Theme.of(context).primaryColor,)),
                      ],
                      ),
                );
  }
}