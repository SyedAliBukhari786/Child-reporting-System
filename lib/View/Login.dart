import 'package:childmonitoringsystem/View/Loginas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lottie/lottie.dart';

import 'admindashboard.dart';


class LoginPage extends StatefulWidget {
  final String initialString;

  const LoginPage({Key? key, required this.initialString}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    receivedString = widget.initialString;
    // Call the method to fetch school data when the widget is initialized
    fetchSchoolData();
    // ... other initialization logic
  }
  Future<void> fetchSchoolData() async {
    try {
      // Get the reference to the document containing the overall data (e.g., School document)
      DocumentSnapshot schoolSnapshot = await _firestore.collection('School_Details').doc('ErQ2VcK4nON3TdPFkegQ').get();

      // Check if the document exists
      if (schoolSnapshot.exists) {
        // Retrieve the fields and store them in variables

        schoolName = schoolSnapshot['SchoolName'] ?? '';


        // Optionally, you can setState to trigger a rebuild if needed
        setState(() {});
      } else {
        // Handle the case where the document doesn't exist
        print('School document does not exist');
      }
    } catch (e) {
      // Handle the error as needed
      print('Error retrieving school data: $e');
    }
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
              (receivedString=="Admin")?SizedBox(height: 50,):SizedBox(),
              Container(
                height: 250,
                width: 300,
                //  color: Colors.deepOrange,
                child: (receivedString=="Admin")? Lottie.asset('assets/admin.json'): Lottie.asset('assets/schholloginanimation.json'),
              ),
             // Text("$schoolName", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),),
              Text(receivedString=="Admin" ?"Admin "+"Login": "Parent's "+"Login", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(color: Colors.green, fontSize: 30),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: ScreenWidth*0.85,

                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children :[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(receivedString=="Admin" ?"Email": "Phone Number", style: TextStyle(color: Colors.black),),
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
                              receivedString=="Admin"?  Icons.email:Icons.phone,
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
                                _loading ? null : _login();  // Handle button press
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: receivedString=="Admin" ? Color(0xFF1F979E): Colors.orange,
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
                    child: (receivedString=="Admin") ? Lottie.asset('assets/admin.json'):Lottie.asset('assets/schholloginanimation.json'),

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
                        Text(receivedString=="Admin" ?"Admin "+"Login": "Parent's "+"Login", textAlign: TextAlign.center, style: GoogleFonts.josefinSans(color: Colors.green, fontSize: 20),),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children :[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Text(receivedString=="Admin" ?"Email": "Phone Number", style: TextStyle(color: Colors.black),),
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
                                        receivedString=="Admin" ? Icons.email: Icons.phone,
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
                                      _loading ? null : _login();  // Handle button press
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: receivedString=="Admin" ? Color(0xFF1F979E): Colors.orange,
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
  }


  Future<void> _login() async {
    if (_validateInputs()) {
      setState(() {
        _loading = true;
      });

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        User? user = userCredential.user;
        if (user != null) {
          bool isAdmin = await _checkIfAdmin(user.uid);
          if (isAdmin) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminDashboard()),
            ).then((_) {
              // This block will be executed when the AdminDashboard screen is popped
              Navigator.popUntil(context, ModalRoute.withName('/LoginPage'));
            });
          } else {
            _showErrorSnackbar('You are not an admin.');
            await _auth.signOut();
          }
        }
      } catch (e) {
        _showErrorSnackbar(e.toString());
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<bool> _checkIfAdmin(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .where('adminid', isEqualTo: userId)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      _showErrorSnackbar('Failed to check admin status: ${e.toString()}');
      return false;
    }
  }

  bool _validateInputs() {
    if (_emailController.text.trim().isEmpty || !_emailController.text.contains('@')) {
      _showErrorSnackbar('Enter a valid email address.');
      return false;
    } else if (_passwordController.text.isEmpty) {
      _showErrorSnackbar('Enter a valid password.');
      return false;
    }
    return true;
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }



}
