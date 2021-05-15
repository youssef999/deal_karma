import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/register2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'colorr.dart';
import 'screen.dart';
import 'screen2.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }


  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose()
  {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     /* appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          iconTheme: IconThemeData(color: Colors.red),
          title:Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                     Colors.white,

                    Colors.lightBlueAccent,

                    // Colors.lightBlueAccent,
                    //Colors.white,
                  ])),
              height:30,
              child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width:40,
                      ),
                      *//* Container(
                 width:80,
                 child:Image.asset('assets/l1.jfif')
               ),*//*
                      Text( " Coin",style:TextStyle(color:Colors.red,fontWeight:FontWeight.bold,fontSize:23)),
                      Text( "s",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:23)),
                      //  Text("  Broker",style:TextStyle(color:Colors.lightBlue,fontWeight:FontWeight.bold,fontSize:21)),
                    ],
                  ))
          ),
          //backgroundColor: Colors.lightBlueAccent,
          actions: <Widget>[
            SizedBox(
              height:10,
            ),




          ]
      ),*/
      body:

      /*StreamBuilder(
        stream:
        FirebaseFirestore.instance.collection('users')
         .where("username",isEqualTo:widget.ud)
        .snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    final docs = snapshot.data.docs;
    int len = docs.length;

    if (!snapshot.hasData) return Center(child: Text('Loading'));
    switch (snapshot.connectionState) {
    case ConnectionState.waiting:
    return new Text('Loading...');
//.where("category", isEqualTo:"tec")
    default:
    return Container(
    color:Colors.red,
    child: ListView.builder(
    itemCount: snapshot.data.documents.length,
    itemBuilder: (context, index) {
    DocumentSnapshot posts = snapshot.data.documents[index];
    int len=snapshot.data.documents.length;
    return Flexible(*/
    Container(
    color:Colors.white,
    //Color.fromRGBO(41, 30, 83, 1),
    padding: EdgeInsets.all(16),




    child: Form(
    key: _formkey,
    child: Column(
    children: <Widget>[
      SizedBox(
          height:20
      ),

       Row(
         children:<Widget>[
           Container(
             width:120,
             height:50,
             decoration: BoxDecoration(
                 color:Colors.white,
                 // color:Colors.lightBlueAccent,
                 borderRadius: BorderRadius.only(
                   bottomLeft: Radius.circular(50),
                   topLeft:Radius.circular(30),
                   topRight:Radius.circular(30),
                   bottomRight: Radius.circular(50),
                 )
             ),
             child:Center(child: Text('Login',style:TextStyle(color:Colors.purple,fontSize:25,fontWeight:FontWeight.w900),)),
           ),
         ]
       ),
      Container(
        width:400,
        height:190,
        color:Colors.lightBlueAccent[300],
        /* decoration: BoxDecoration(
                   color:Colors.white,
                   // color:Colors.lightBlueAccent,
                   borderRadius: BorderRadius.only(
                     bottomLeft: Radius.circular(50),
                     topLeft:Radius.circular(30),
                     topRight:Radius.circular(30),
                     bottomRight: Radius.circular(50),
                   )
               ),*/
        child:Image.asset('assets/signup.png'),
      ),
      SizedBox(
          height:15
      ),
    TextFormField(/*/Email*/
    controller: _emailcontroller,
    cursorColor:Colors.purple,
    style: TextStyle(fontSize: 18, color: Colors.black),
    decoration: InputDecoration(
    border:OutlineInputBorder(
    borderSide: const BorderSide(
    color: Colors.purpleAccent,
    width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
    ),
    //fillColor:Colors.white,
    filled: true,
    hintText: "Your Email",hintStyle:TextStyle(color:Colors.black45,),
    prefixIcon: Icon(Icons.person,color:Colors.purple),
    ),
    validator: (value) {
    if(value.isEmpty){
    return 'Please Fill Email Input';
    }


    },
    ),
    SizedBox(
    height: 20,
    ),
    TextFormField(/*Password*/
    cursorColor:Colors.purple,

    obscureText: true,
    controller: _passwordcontroller,
    style: TextStyle(fontSize: 18, color: Colors.black),
    decoration: InputDecoration(
    border:OutlineInputBorder(
    borderSide: const BorderSide(
    color: Colors.purpleAccent,
    width: 2.0),
    borderRadius: BorderRadius.circular(30.0),
    ),
    // fillColor: Colors.white,
    filled: true,

    hintText: "Password",hintStyle:TextStyle(color:Colors.black45,),
    prefixIcon: Icon(Icons.lock,color:Colors.purple),
    ),
    validator: (value){
    if(value.isEmpty){
    return 'Please Fill Password Input';
    }
    },
    ),
    SizedBox(
    height: 15,
    ),
    Container(
      width:160,

     /* decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.purple,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(26)),
      ),*/
    child: Container(
     // color:  Colors.purple,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color:  Colors.purple,
      child: Text('Login',style: TextStyle(color: Colors.white,fontSize:24),),
      onPressed: () async {

      if(_formkey.currentState.validate()){

      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);

      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      String ud=userData['username'];
      if(result != null)
      {
      // pushReplacement
      print('welcomee');
      Navigator. pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen2(ud)),
      );

      }
      else{
      print('user not found');
      }
      }
      },
      ),
    ),
    ),
    Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
    children: <Widget>[
    SizedBox(width:20,),
    Expanded(
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Divider(
    thickness: 1,
    ),
    ),
    ),
    Text("O R",style: TextStyle(
    color:Colors.red,
    fontSize:22,fontWeight: FontWeight.w700,fontStyle:FontStyle.italic),),
    Expanded(
    child: Padding(
    padding: EdgeInsets.symmetric(horizontal:10),
    child: Divider(
    thickness:1,
    ),
    ),
    ),

    ],
    )
    ),
    SizedBox(
    height:5,
    ),
    FlatButton(

    onPressed: () async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen2() ) );
    },
    child: Container(
    margin: EdgeInsets.symmetric(vertical:20),
    //padding: EdgeInsets.only(left:15,bottom:15,right:15),
    //alignment: Alignment.bottomCenter,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text(
    "Don't have an account ?",style: TextStyle(
    color:Colors.purple,
    fontSize:18,fontWeight: FontWeight.w600,fontStyle:FontStyle.italic),
    ),
    SizedBox(
    width: 10,
    ),
    Text( "Sign up",style: TextStyle(
    color:Colors.black,
    fontSize:18,fontWeight: FontWeight.w900,fontStyle:FontStyle.italic),
    ),
    ],
    ),
    ),
    )

    ],
    )
    ),
    ));


  }



}