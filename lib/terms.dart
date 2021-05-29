import 'package:flutter/material.dart';

import 'register2.dart';

class terms extends StatelessWidget {

  final String txt;

  terms(this.txt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          color: Color(0xFF6F35A5),
    child: Column(
    children:<Widget>[
      SizedBox(
          height:40
      ),
      Row(
        children: [
          SizedBox(
              width:40
          ),
          Container(
              child:Text('Terms' + '&' + 'Conditions',style:TextStyle(color:Colors.red,fontSize:22,fontWeight:FontWeight.w600,fontStyle:FontStyle.italic),)
          ),
          SizedBox(
              width:5
          ),
          Icon(Icons.ac_unit_rounded,color:Colors.cyanAccent,),
        ],
      ),
      SizedBox(
          height:34
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
                    'Hello Mr '+txt,
                    style:TextStyle(color:Colors.white,fontSize:17,fontWeight:FontWeight.w900),
                  ),
                  SizedBox(
                      height:10
                  ),
                  Text(
                   "Welcome to Dealkarma community",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                      height:6
                  ),
                  Text(
                  " Kindly note that your information is private ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                      height:6
                  ),
                  Text(
                    "and  there is no credit check required ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                      height:6
                  ),
                  Text(
                    "Its only needed for the mobile service ID.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                      height:6
                  ),
                  Text(
                    "We are happy that you joined our community feel safe and watch more!.",
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
           /* Positioned(
              bottom: 190,
              left: 210,
              child: Image(
                image: AssetImage('assets/t1.png'),
                height: 182,
              ),
            ),*/
          ],
        ),
      ),
      SizedBox(
        height:12,
      ),
      RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29)),
          color: Colors.deepPurpleAccent,
          child:Text('Return To Submit',style:TextStyle(color:Colors.white,fontSize:17,fontWeight:FontWeight.w900),),
          onPressed:(){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return RegisterScreen2();
                }));
          }),
        ],

    )
    ));
  }
}
