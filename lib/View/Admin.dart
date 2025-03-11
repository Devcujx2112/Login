import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/View/Login.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Page',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ElevatedButton(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          }, child: Text('Back to Login'))
          ],
        ),
      ),
    );
  }
}
