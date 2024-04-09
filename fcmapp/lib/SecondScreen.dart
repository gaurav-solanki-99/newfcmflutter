import 'package:fcmapp/Services/FirebaseServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SecondScreeen extends StatefulWidget {
  const SecondScreeen({Key? key}) : super(key: key);

  @override
  State<SecondScreeen> createState() => _SecondScreeenState();
}

class _SecondScreeenState extends State<SecondScreeen> {

var purpulecolor = Color(0xFFBC7FCD);
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(Get.find<MyRedirectionService>().data.value),
            ),

            Padding(

              padding:  EdgeInsets.all(10.0),
              child: Card(
                color: Colors.black,
             child: Stack(
               children: [

                 Container(
                   width: width,

                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(),


                    ClipRRect(
                             borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0), // adjust the radius as needed
                  bottomRight: Radius.circular(10.0), // adjust the radius as needed
                             ),
                             child: Image.asset(
                  "images/g1.png",
                  height: 150,
                  fit: BoxFit.fill,
                             ),
                           )
                     ],
                     )

                 ),

                 Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                         gradient: LinearGradient(colors: [
                           Colors.white60,
                           Colors.black54.withOpacity(0.4),
                           Colors.black.withOpacity(0.9)

                         ], begin: Alignment.topLeft, end: Alignment.bottomRight)

                     ),
                     width: width,height:150,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [


                     ],
                   ),

                 ),

                 Container(
                   height: 150,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Padding(
                         padding:  EdgeInsets.only(left: 10,top: 15),
                         child: Text("Gaurav Solanki",
                           style: TextStyle(color: Colors.white,
                           fontSize: 20,
                           ),),
                       ),
                       Container(
                           margin:  EdgeInsets.only(left: 10,),
                         height: 4,
                         width: (width*0.3)+10,
                         color: purpulecolor
                       ),

                       SizedBox(height: 5,),
                       Row(
                         children: [

                           Container(
                               margin:  EdgeInsets.only(left: 10,),
                               height: 4,
                               width: 4,
                               color: purpulecolor
                           ),
                           Padding(
                             padding:  EdgeInsets.only(left: 10,),
                             child: Text("Flutter Developer",
                               style: TextStyle(color: Colors.white,
                                 fontSize: 10,
                               ),),
                           ),

                         ],
                       ),
                       SizedBox(height: 5,),
                       Row(
                         children: [

                           Container(
                               margin:  EdgeInsets.only(left: 10,),
                               height: 4,
                               width: 4,
                               color: purpulecolor
                           ),
                           Padding(
                             padding:  EdgeInsets.only(left: 10,),
                             child: Text("Android Developer",
                               style: TextStyle(color: Colors.white,
                                 fontSize: 10,
                               ),),
                           ),

                         ],
                       ),
                       SizedBox(height: 5,),
                       Row(
                         children: [

                           Container(
                               margin:  EdgeInsets.only(left: 10,),
                               height: 4,
                               width: 4,
                               color: purpulecolor
                           ),
                           Padding(
                             padding:  EdgeInsets.only(left: 10,),
                             child: Text("Flutter GetX",
                               style: TextStyle(color: Colors.white,
                                 fontSize: 10,
                               ),),
                           ),

                         ],
                       )
                     ],
                   ),
                 )


               ],
             ),

              ),
            )
          ],
        ),
      ),
    );
  }
}
