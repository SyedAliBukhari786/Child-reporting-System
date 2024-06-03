import 'dart:math';

import 'package:childmonitoringsystem/View/Teachershatespeechview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class Teachers extends StatefulWidget {
  const Teachers({super.key});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  final TextEditingController teachername = TextEditingController();
  final TextEditingController teachercontact = TextEditingController();
  final TextEditingController teachereducation = TextEditingController();
  final TextEditingController teachersubjects = TextEditingController();
  final TextEditingController teacheremail = TextEditingController();
  final TextEditingController teacherpassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();




  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to delete a document from Firestore
  void deleteTeacher(String docId) async {
    try {
      await _firestore.collection('Teachers').doc(docId).delete();
      showSnackbar("Teacher deleted successfully.", Colors.green);
    } catch (e) {
      showSnackbar("Failed to delete teacher.", Colors.red);
    }
  }



  // Function to show delete confirmation dialog
  Future<void> _showDeleteConfirmationDialog(String docId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this teacher?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                deleteTeacher(docId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Teacher Registration')),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: teachername,
                          decoration: InputDecoration(
                            labelText: 'Teacher Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        TextField(
                          controller: teachercontact,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Contact',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        TextField(
                          controller: teachereducation,
                          decoration: InputDecoration(
                            labelText: 'Education',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        TextField(
                          controller: teachersubjects,
                          decoration: InputDecoration(
                            labelText: 'Subjects',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        TextField(
                          controller: teacheremail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        TextField(
                          controller: teacherpassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        TextField(
                          controller: confirmPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        )


                        ,SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            if (validateFields()) {
                              // Validate successfully, proceed with Firebase registration
                              try {
                                UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                                  email: teacheremail.text,
                                  password: teacherpassword.text,
                                );

                                // Get the newly created user's ID as the document ID
                                String userId = userCredential.user?.uid ?? '';

                                // Store additional data in the Firestore Collection 'Teachers'
                                await _firestore.collection('Teachers').doc(userId).set({
                                  'Name': teachername.text,
                                  'Contact': teachercontact.text,
                                  'Education': teachereducation.text,
                                  'Subjects': teachersubjects.text,
                                  'Email': teacheremail.text,
                                });




                                // Close the dialog
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Registration Successfull."),
                                  backgroundColor: Colors.green,
                                ));
                              } catch (e) {
                                // Handle registration failure
                                print("Error: $e");
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Registration failed. Please try again."),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          },
                          child: Text('Register'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: 200,
                child: Lottie.asset("assets/teachers2.json"),
              ),
              Text("Teachers", style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),),
              Expanded(
                child: StreamBuilder(
                  stream: _firestore.collection('Teachers').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var teachers = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: teachers.length,
                      itemBuilder: (context, index) {
                        var teacher = teachers[index].data();
                        String docId = teachers[index].id;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: ListTile(
                              title: Center(child: Text('${teacher['Name']}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),)),
                              subtitle: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Lottie.asset("assets/teachers.json"),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.deepPurple),
                                    ),
                                  ),
                                  SizedBox(width: 6,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Contact: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                            Expanded(child: Text(teacher['Contact'])),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Education: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Expanded(child: Text(teacher['Education'])),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Subjects: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                            Expanded(child: Text(teacher['Subjects'])),
                                          ],
                                        ),
                                        SizedBox(height: 6,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            IconButton(
                                              icon: Icon(Icons.edit, color: Colors.green,),
                                              onPressed: () {
                                                _showEditDialog(docId, teacher);
                                              },
                                            ),

                                            IconButton(
                                              icon: Icon(Icons.auto_graph_sharp, color: Colors.red),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => Hatespeechview()),
                                                );
                                              },
                                            ),

                                            IconButton(
                                              icon: Icon(Icons.delete, color: Colors.red),
                                              onPressed: () {
                                                _showDeleteConfirmationDialog(docId);
                                              },
                                            ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      },
                    );
                  },
                ),
              ),
            ],


          ),

        ),
      ),
    );
  }

  bool validateFields() {
    if (teachername.text.isEmpty ||
        teachercontact.text.isEmpty ||
        teachereducation.text.isEmpty ||
        teachersubjects.text.isEmpty ||
        teacheremail.text.isEmpty ||
        teacherpassword.text.isEmpty ||
        confirmPassword.text.isEmpty) {
      showSnackbar("All fields are required.", Colors.red);
      return false;
    } else if (!teacheremail.text.contains('@') || !teacheremail.text.contains('.')) {
      showSnackbar("Invalid email address.", Colors.red);
      return false;
    } else if (teacherpassword.text.length < 8) {
      showSnackbar("Password must be at least 8 characters long.", Colors.red);
      return false;
    } else if (teacherpassword.text != confirmPassword.text) {
      showSnackbar("Passwords do not match.", Colors.red);
      return false;
    } else if (teachercontact.text.length != 11 || !isNumeric(teachercontact.text)) {
      showSnackbar("Invalid contact Number.", Colors.red);
      return false;
    }
    return true;
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  void showSnackbar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }
  // Function to show edit dialog
  Future<void> _showEditDialog(String docId, Map<String, dynamic> teacherData) async {
    TextEditingController nameController = TextEditingController(text: teacherData['Name']);
    TextEditingController contactController = TextEditingController(text: teacherData['Contact']);
    TextEditingController educationController = TextEditingController(text: teacherData['Education']);
    TextEditingController subjectsController = TextEditingController(text: teacherData['Subjects']);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Teacher'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: contactController,
                  decoration: InputDecoration(
                    labelText: 'Contact',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: educationController,
                  decoration: InputDecoration(
                    labelText: 'Education',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: subjectsController,
                  decoration: InputDecoration(
                    labelText: 'Subjects',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update'),
              onPressed: () {
                if (validateFieldss(nameController.text, contactController.text, educationController.text, subjectsController.text)) {
                  updateTeacher(docId, {
                    'Name': nameController.text,
                    'Contact': contactController.text,
                    'Education': educationController.text,
                    'Subjects': subjectsController.text,
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to update a document in Firestore
  void updateTeacher(String docId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection('Teachers').doc(docId).update(newData);
      showSnackbar("Teacher updated successfully.", Colors.green);
    } catch (e) {
      showSnackbar("Failed to update teacher.", Colors.red);
    }
  }




  bool validateFieldss(String name, String contact, String education, String subjects) {
    if (name.isEmpty || contact.isEmpty || education.isEmpty || subjects.isEmpty) {
      showSnackbar("All fields are required.", Colors.red);
      return false;
    } else if (contact.length != 11 || !isNumeric(contact)) {
      showSnackbar("Invalid contact Number.", Colors.red);
      return false;
    }
    return true;
  }
}
