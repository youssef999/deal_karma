
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire99/adsManger.dart';
import 'package:fire99/colorr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'colorr.dart';
import 'colorr.dart';
import 'login.dart';



class profile extends StatefulWidget {

  final String ud;
  profile(this.ud);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<profile> {
  String allposts;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();


  String v;
  TextEditingController _searchController = TextEditingController();
  Future resultsLoaded;
  final _nativeAd=NativeAdmobController();
  AdmobBannerSize bannerSize;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobInterstitial intersitialAd;

  @override
  void initState() {
    setState(() {

    });
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;

    intersitialAd = AdmobInterstitial(
        adUnitId:  AdmobInterstitial.testAdUnitId,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          if (event == AdmobAdEvent.closed) intersitialAd.load();
          //  handleEvent(event, args, 'Interstitial');
        });
    _nativeAd.reloadAd(forceRefresh:true);
    intersitialAd.load();


    void showSnackBar(String content) {

      scaffoldState.currentState.showSnackBar(
        SnackBar(
          content: Text(content),
          duration: Duration(milliseconds: 1500),
        ),
      );
    }


    void handleEvent(
        AdmobAdEvent event, Map<String, dynamic> args, String adType) {
      switch (event) {
        case AdmobAdEvent.loaded:
          showSnackBar('New Admob $adType Ad loaded!');
          break;
        case AdmobAdEvent.opened:
          showSnackBar('Admob $adType Ad opened!');
          break;
        case AdmobAdEvent.closed:
          showSnackBar('Admob $adType Ad closed!');
          break;
        case AdmobAdEvent.failedToLoad:
          showSnackBar('Admob $adType failed to load. :(');
          break;
        case AdmobAdEvent.rewarded:
          showDialog(
            context: scaffoldState.currentContext,
            builder: (BuildContext context) {
              return WillPopScope(
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Reward callback fired. Thanks Andrew!'),
                      Text('Type: ${args['type']}'),
                      Text('Amount: ${args['amount']}'),
                    ],
                  ),
                ),
                onWillPop: () async {
                  scaffoldState.currentState.hideCurrentSnackBar();
                  return true;
                },
              );
            },
          );
          break;
        default:
      }
    }




  }



  Future update(String newEmail) async {

    var message;
    FirebaseUser firebaseUser =await FirebaseAuth.instance.currentUser;
    firebaseUser
        .updateEmail(newEmail)
        .then(
          (value) => message = 'Success',
    )
        .catchError((onError) => message = 'error');
    return message;
  }
  Future update2(String newPass) async {
    var message;
    FirebaseUser firebaseUser =await FirebaseAuth.instance.currentUser;
    firebaseUser
        .updatePassword(newPass)
        .then(
          (value) => message = 'Success',
    )
        .catchError((onError) => message = 'error');
    return message;
  }
  @override
  void dispose() {
    intersitialAd.dispose();
    _nativeAd.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userData =FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 30, 83, 1),
      appBar: AppBar(
          backgroundColor:btnforGroundColr,
          title:(Center(
              child: Row(
                children: [
                  SizedBox(
                    width:40,
                  ),
                  /* Container(
                 width:80,
                 child:Image.asset('assets/l1.jfif')
               ),*/
                  Text(  "Deal",style:TextStyle(color:kPrimaryLightColor,fontWeight:FontWeight.bold,fontSize:23)),
                  Text( "K",style:TextStyle(color:kPrimaryColor,fontWeight:FontWeight.bold,fontSize:23)),
                  Text( "arma",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:23)),

                  //  Text("  Broker",style:TextStyle(color:Colors.lightBlue,fontWeight:FontWeight.bold,fontSize:21)),
                ],
              ))
          ),
          actions: <Widget>[
            SizedBox(
              width:20,
            ),

          ]
      ),


      //drawer: SidebarPage(),

      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              btnforGroundColr,
              btnbackGroundColr
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
            //.fromRGBO(41, 30, 83, 1),
        child: Column(
            children: [
              /* Container(
                  width:200,
                  height:60,
                  child:NativeAdmob(
                    adUnitID:AdsManger.nativeAdunit,
                    numberAds:3,
                    controller: _nativeAd,
                    type:NativeAdmobType.banner,
                  )
              ),
*/
              SizedBox(
                height:7,
              ),
              Flexible(
                //child: Expanded(
                child: StreamBuilder(

                    stream:
                    FirebaseFirestore.instance.collection('users')
                        .where("username",isEqualTo:widget.ud)
                    //.orderBy("img",descending:true )
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                      final docs =snapshot.data.docs;
                      int len=docs.length;

                      if (!snapshot.hasData) return Center(child: Text('Loading'));
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return new Text('Loading...');
//.where("category", isEqualTo:"tec")
                        default:
                          return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot posts = snapshot.data.documents[index];
                                int len=snapshot.data.documents.length;
                                // (profile.imgUrl == null) ? AssetImage('images/user-avatar.png') : NetworkImage(profile.imgUrl)
                                return Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          btnforGroundColr,
                                          btnbackGroundColr
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                    ),
                                    child: Column(
                                      children: <Widget>[

                                        Row(
                                          children: [
                                            SizedBox(
                                                width:40
                                            ),
                                            Container(
                                                child:Text('Welcome ' +posts.data()['username']+' to DealKarma ',style:TextStyle(color:Colors.black,fontSize:17,fontWeight:FontWeight.w600,fontStyle:FontStyle.italic),)
                                            ),
                                            SizedBox(
                                                width:20
                                            ),
                                            Icon(Icons.ac_unit_rounded,color:Colors.cyanAccent,),
                                          ],
                                        ),
                                        SizedBox(
                                            height:20
                                        ),

                                        Row(
                                          children: [
                                            SizedBox(
                                              width:30,
                                            ),
                                            Container(
                                              width:100,
                                              height:112,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.lightBlue,
                                                    Colors.lightBlue[300],
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(70)),
                                              ),
                                              child:Center(child: Text( posts.data()['username'][0],style:TextStyle(color:Colors.white,fontSize:22,fontWeight:FontWeight.w900),)),
                                            ),
                                            SizedBox(
                                              width:80,
                                            ),
                                            Column(
                                              children: [

                                                Container(
                                                    child:Text( posts.data()['coins'],style:TextStyle(color:Colors.cyanAccent,fontSize:22,fontWeight:FontWeight.w900),)
                                                ),
                                                SizedBox(
                                                  height:5,
                                                ),
                                                Container(
                                                    child:Text("Coins",style:TextStyle(color:Colors.white,fontSize:17,fontWeight:FontWeight.w900),)
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Stack(
                                            overflow: Overflow.visible,
                                            children: [
                                              Transform(
                                                transform: Matrix4.skewY(-0.05),
                                                child: Container(
                                                  padding: EdgeInsets.all(24),
                                                  height: 310,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                      colors: [
                                                        Colors.purpleAccent[200],
                                                        Colors.blue
                                                      ],
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(18.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Your Profile',
                                                      style:TextStyle(color:Colors.white,fontSize:17,fontWeight:FontWeight.w900),
                                                    ),
                                                    SizedBox(
                                                        height:10
                                                    ),
                                                    Text(
                                                      posts.data()['username'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w300),
                                                    ),
                                                    SizedBox(
                                                        height:6
                                                    ),
                                                    Text(
                                                      posts.data()['email'],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w300),
                                                    ),
                                                    SizedBox(
                                                        height:6
                                                    ),
                                                    Text(
                                                      "Convert your Coins to money ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w300),
                                                    ),
                                                    SizedBox(
                                                        height:6
                                                    ),
                                                    Text(
                                                      "1000 coins =1\$",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w300),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          top: 57, right: 15, left: 70),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          /*  CircularPercentIndicator(
                                radius: 55.0,
                                lineWidth: 6.0,
                                animation: true,
                                percent: 0.2,
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Colors.black87,
                              ),

                             */
                                                         /* InkWell(
                                                            child: Transform(
                                                              transform: Matrix4.skewX(-0.05),
                                                              origin: Offset(50.0, 50.0),
                                                              child: Material(
                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(20)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 30,
                                                                      right: 30,
                                                                      top: 10,
                                                                      bottom: 10),
                                                                  child: InkWell(
                                                                    child: Text(
                                                                      'make a deal',
                                                                      style: TextStyle(
                                                                          color: Colors.red.shade600,
                                                                          fontSize: 20,
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap:(){
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) {
                                                                    //  return two();
                                                                  }));
                                                            },
                                                          ),*/
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 190,
                                                left: 210,
                                                child: Image(
                                                  image: AssetImage('assets/t1.png'),
                                                  height: 182,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),



                                      ],
                                    ),
                                  ),
                                );
                              });
                      }
                    }
                ),
              ),
              //),

              // Container(
              //   color: Color.fromRGBO(41, 30, 83, 1),
              //   padding: const EdgeInsets.only(top:40),
              //   child: CurvedNavigationBar(
              //       color:Colors.indigo[900],
              //       backgroundColor: Color.fromRGBO(41, 30, 83, 1),
              //       //buttonBackgroundColor:Colors.blue,
              //       items:<Widget>[
              //         Icon(Icons.home,size:24,color:Colors.red),
              //         //  Icon(Icons.add_box,size:24,color:Colors.blue),
              //         Icon(Icons.messenger_rounded,size:24,color:Colors.red),
              //         // Icon(Icons.account_circle,size:24,color:Colors.white),
              //       ],
              //
              //       animationCurve:Curves.bounceOut,
              //       onTap:(index) async {
              //         final user = FirebaseAuth.instance.currentUser;
              //         final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
              //         String ud=userData['username'];
              //
              //
              //         /* if(index==1)
              //            {
              //              intersitialAd.show();
              //              Navigator.push(
              //                  context,
              //                  MaterialPageRoute(builder: (context) {
              //                return AddPost();
              //              }));
              //         }*/
              //         if(index==1){
              //           intersitialAd.show();
              //           Navigator.push(context, MaterialPageRoute(builder: (context) =>ChatScreen2(ud)));
              //         }
              //
              //       }
              //
              //   ),
              // )

            ]),
      ),



    );

  }

}
