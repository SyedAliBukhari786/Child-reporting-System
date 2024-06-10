import 'dart:ffi';
import 'dart:ui';
import 'package:childmonitoringsystem/View/Loginas.dart';
import 'package:childmonitoringsystem/View/students.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

import 'HateSpeechDetector.dart';
import 'TeachersRegistrations.dart';
import 'classes.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {


  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.grey[200],
        body: Container(

          height:  double.infinity,
          width:  double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    child: Row(
                      children: [
                       Expanded(
                           flex: 7,child: Container(

                         child: Row(
                           children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: buildCircularContainer(Colors.white, "assets/adminnew.png"),
                                    ),
                             
                             
                             Padding(
                               padding: const EdgeInsets.all(4.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("Zeeshan Ashraf", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),),
                                   SizedBox(height: 5,),
                                   Text("(Admin)", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),)
                                 ],


                               ),
                             )

                           ],
                         ),



                       )),
                        Expanded(flex: 3,child: GestureDetector(onTap: () async {
                         await _auth.signOut();
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => Selectin()),
                         );

                        },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 7.0),
                                  child: Container(
                                    height: 25,
                                    width: 70,
                                    child: Center(child: Text("Logout", style: TextStyle(
                                      fontSize: 11,color: Colors.white

                                    ),),),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),


                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),


                    ),


                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                   Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right :4),
                        child: Container(
                          height: 150,
                        //  width: 100,
                          //width: double.infinity,
                          
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Hate Speech", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                      Image.asset("assets/megaphone.png", height: 30, width: 30,)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),


                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Column(
                                    children: [
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Teachers", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                              // color: Colors.blue, // Background color of the container
                                              border: Border.all(
                                                color: Colors.white, // White border color
                                                width: 2.0, // Border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Center(
                                                child:Text("9", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Today", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                              // color: Colors.blue, // Background color of the container
                                              border: Border.all(
                                                color: Colors.white, // White border color
                                                width: 2.0, // Border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Center(
                                                child:Text("3", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("This Month", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                              // color: Colors.blue, // Background color of the container
                                              border: Border.all(
                                                color: Colors.white, // White border color
                                                width: 2.0, // Border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Center(
                                                child:Text("9", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],



                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),

                          ),


                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right :8),
                        child: Container(
                          height: 150,
                          //  width: 100,
                          //width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Activity Tracker", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                                      Image.asset("assets/activity.png", height: 30, width: 30,)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Column(
                                    children: [
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Lazy", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              // color: Colors.blue, // Background color of the container
                                              border: Border.all(
                                                color: Colors.white, // White border color
                                                width: 2.0, // Border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Center(
                                                child:Text("9", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Unattentive", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              // color: Colors.blue, // Background color of the container
                                              border: Border.all(
                                                color: Colors.white, // White border color
                                                width: 2.0, // Border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Center(
                                                child:Text("3", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Mis Behavior", style:  TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              // color: Colors.blue, // Background color of the container
                                              border: Border.all(
                                                color: Colors.white, // White border color
                                                width: 2.0, // Border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Center(
                                                child:Text("9", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],



                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15),

                          ),


                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(flex: 8,child: Container(
                         child: Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(4.0),
                               child: buildCircularContainer(Colors.white, "assets/student.png"),
                             ),

                             Padding(
                               padding: const EdgeInsets.all(4.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("Total Registered Students", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                   SizedBox(height: 5,),
                                   Text("(School Name)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),)
                                 ],


                               ),
                             )
                           ],
                         ),





                        )),
                        Expanded(flex: 2,child: Container(
                          child: Container(
                            height: 40,


                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              // color: Colors.blue, // Background color of the container
                              border: Border.all(
                                color: Colors.white, // White border color
                                width: 2.0, // Border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Center(
                                child:Text("23", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ),

                        )),
                      ],



                    ),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    buildCustomContainer("Students", "assets/students.json"),
                      buildCustomContainer("Teachers", "assets/teachers.json"),
                      buildCustomContainer("Classes", "assets/classes.json"),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildCustomContainer("Activity\nTracker", "assets/ActivvityTracker.json",   ),
                      buildCustomContainer("Hate Speech\nDetector", "assets/Hatespeech.json"),
                      buildCustomContainer("Test\nReports", "assets/paper.json"),

                    ],
                  ),
                )

              ],






            ),
          ),




        ),
      ),
    );
  }





  Widget buildCustomContainer( String title, String Path) {
    return GestureDetector(
      onTap:  () {
        if(title=="Classes"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Class()),
          );
        } else   if(title=="Students"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Students()),
          );
        }else   if(title=="Teachers"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Teachers()),

          );
        }
        else   if(title=="Hate Speech\nDetector"){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  SpeechScreen()),

          );
        }


      },
      child: Container(
        width: 90.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(20.0),
        ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex :7,
                  child: Container(
                child:Center(child: Lottie.asset(Path)),

              )),

            //
             // Spacing between image and text
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      title,textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

      ),
    );
  }




  Widget buildCircularContainer(Color color, String path ) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
       // color: Colors.blue, // Background color of the container
        border: Border.all(
          color: Colors.lightBlue, // White border color
          width: 2.0, // Border width
        ),
      ),
      child: Center(
        child: ClipOval(
          child: Image.asset(
            path, // Update with your PNG image path
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

