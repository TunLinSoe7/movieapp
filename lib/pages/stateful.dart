import 'package:flutter/material.dart';
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? vari;
  @override
  void initState() {
   futureEg().then((value) {
     vari =value;
     setState(() {

     });
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: vari == null ? const CircularProgressIndicator():Text(vari ?? 'No Data'),
      ) ,
    );
  }
}
Future<String> futureEg (){
  return Future.delayed(const Duration(seconds: 3),(){
    return "Hello";
  });
}