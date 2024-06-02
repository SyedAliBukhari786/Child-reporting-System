import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class Teacherlogin extends StatefulWidget {
  const Teacherlogin({super.key});

  @override
  State<Teacherlogin> createState() => _TeacherloginState();
}

class _TeacherloginState extends State<Teacherlogin> {
  late String receivedString;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  String schoolName = '';


  @override
  void initState() {
    super.initState();

    // Call the method to fetch school data when the widget is initialized

    // ... other initialization logic
  }


  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double ScreenHeight= MediaQuery.of(context).size.height;
    double ScreenWidth= MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: (ScreenWidth<500)? SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(height: 50,),

              Container(
                height: 250,
                width: 300,
                //  color: Colors.deepOrange,
                child:  Lottie.asset('assets/teachers.json')
              ),
              // Text("$schoolName", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),),
              Text("Teacher's Login", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(color: Colors.green, fontSize: 30),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: ScreenWidth*0.85,

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text("Email", style: TextStyle(color: Colors.black),),
                        ),
                        SizedBox(height: 1,),
                        TextField(

                          style: TextStyle(color: Colors.black),
                          controller: _emailController,
                          decoration: InputDecoration(

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.green,
                            ),
                          ),

                        ),
                        SizedBox(height: 20,),


                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text("Password", style: TextStyle(color: Colors.black),),
                        ),
                        SizedBox(height: 1,),
                        TextField(
                          style: TextStyle(color: Colors.black),
                          obscureText: !isPasswordVisible,
                          controller: _passwordController,
                          decoration: InputDecoration(

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.green,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox( height: 30,),
                        Center(
                          child: Container(
                            width: ScreenWidth * 0.6,
                            child: ElevatedButton(
                              onPressed: () {
                               // _loading ? null : _login();  // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:  Color(0xFFFF7685),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: _loading
                                    ? CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),]
                  ),
                ),
              ),







            ],
          ),
        ) :SingleChildScrollView(

          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    // color: Colors.orange,
                    child: Lottie.asset('assets/teachers.json'),

                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(


                    child: Column(

                      children: [
                        //  Text("Allied School", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),),
                        Text("Teacher's Login", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(color: Colors.green, fontSize: 20),),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children :[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text("Email", style: TextStyle(color: Colors.black),),
                                ),
                                SizedBox(height: 1,),
                                Container(
                                  width: 400,
                                  child: TextField(

                                    style: TextStyle(color: Colors.black),
                                    controller: _emailController,
                                    decoration: InputDecoration(

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      prefixIcon: Icon(
                                       Icons.email,
                                        color: Colors.green,
                                      ),
                                    ),

                                  ),
                                ),
                                SizedBox(height: 20,),


                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text("Password", style: TextStyle(color: Colors.black),),
                                ),
                                SizedBox(height: 1,),
                                Container(
                                  width: 400,
                                  child: TextField(
                                    style: TextStyle(color: Colors.black),
                                    obscureText: !isPasswordVisible,
                                    controller: _passwordController,
                                    decoration: InputDecoration(

                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.green,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible = !isPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox( height: 30,),
                                Container(
                                  width: 400,

                                  child: ElevatedButton(
                                    onPressed: () {
                                     // _loading ? null : _login();  // Handle button press
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFF7685),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: _loading
                                          ? CircularProgressIndicator(color: Colors.white)
                                          : Text(
                                        'Login',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ),



            ],
          ),
        ),
      ),
    ));
  }}
