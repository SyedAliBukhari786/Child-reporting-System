import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'StudentDetails.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {

  final TextEditingController studentname = TextEditingController();
  final TextEditingController parentscontact = TextEditingController();
  final TextEditingController parentsname = TextEditingController();
  final TextEditingController classname = TextEditingController();
  final TextEditingController rollno = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> classNames = [];
  List<String> list_type = ["Select Class"];

  Future<bool> parentExists(String email) async {
    try {
      final result = await _auth.fetchSignInMethodsForEmail(email);
      return result.isNotEmpty;
    } catch (e) {
      print("Error checking if parent exists: $e");
      return false;
    }
  }

  Future<void> registerParent(String email, String password, String parentName, String parentContact) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;

      await _firestore.collection('Parents').doc(uid).set({
        'parentName': parentName,
        'parentContact': parentContact,
      });

      print("Parent registered successfully");
    } catch (e) {
      print("Error registering parent: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchClassNames();
    setState(() {
      list_type.addAll(classNames as Iterable<String>);
      print(list_type);
    });
  }

  Future<void> fetchClassNames() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection("Classes").orderBy("className",descending: false).get();
      classNames = querySnapshot.docs.map((doc) => doc['className'] as String).toList();
      setState(() {
        list_type.addAll(classNames);
        print(list_type);
      });
    } catch (e) {
      print("Error fetching class names: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue_type = list_type.first;
    return Scaffold(
      body: ListView.builder(
        itemCount: classNames.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(classNames[index]),
              trailing: Icon(Icons.arrow_forward, color: Colors.green,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetails(className: classNames[index]),
                  ),
                );
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Center(child: Text('Student Registration')),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: studentname,
                        decoration: InputDecoration(
                          labelText: 'Student Name',
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
                        controller: parentsname,
                        decoration: InputDecoration(
                          labelText: 'Parents Name',
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
                        controller: parentscontact,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Parents Contact',
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
                        controller: rollno,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Roll No',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      TextField(
                        controller: classname,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Class',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      Center(
                        child: DropdownButton<String>(
                          value: dropdownValue_type,
                          icon: const Icon(Icons.arrow_drop_down_outlined),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue_type = value!;
                              classname.text = dropdownValue_type;
                            });
                          },
                          items: list_type.map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (validateFields()) {
                            try {
                              CollectionReference classesCollection = _firestore.collection('Classes');
                              DateTime now = DateTime.now();
                              Timestamp timestamp = Timestamp.fromDate(now);

                              QuerySnapshot classQuery = await classesCollection.where('className', isEqualTo: classname.text.trim()).get();

                              if (classQuery.docs.isNotEmpty) {
                                String classDocumentId = classQuery.docs.first.id;
                                String parentEmail = "${parentscontact.text}@gmail.com";
                                String parentPassword = "12345678";

                                bool exists = await parentExists(parentEmail);

                                if (exists) {
                                  await _firestore.collection('Students').add({
                                    'StudentName': studentname.text,
                                    'ParentContact': parentscontact.text,
                                    'ParentName': parentsname.text,
                                    'Class': classname.text,
                                    "Class_ID": classDocumentId,
                                    'Rollno': rollno.text.trim(),
                                    "Date": timestamp,
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Parent already exists for another student."),
                                  ));
                                } else {
                                  await registerParent(parentEmail, parentPassword, parentsname.text, parentscontact.text);

                                  await _firestore.collection('Students').add({
                                    'StudentName': studentname.text,
                                    'ParentContact': parentscontact.text,
                                    'ParentName': parentsname.text,
                                    'Class': classname.text,
                                    "Class_ID": classDocumentId,
                                    'Rollno': rollno.text.trim(),
                                    "Date": timestamp,
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("Student details saved successfully."),
                                  ));
                                }

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Registration Successful."),
                                  backgroundColor: Colors.green,
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Class not found."),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            } catch (e) {
                              print("Error: $e");
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Registration failed.$e"),
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
        child: Icon(Icons.person, color: Colors.white),
        backgroundColor: Colors.green,
      ),
    );
  }

  bool validateFields() {
    if (studentname.text.isEmpty ||
        parentscontact.text.isEmpty ||
        parentsname.text.isEmpty ||
        classname.text.isEmpty ||
        rollno.text.isEmpty) {
      showSnackbar("All fields are required.", Colors.red);
      return false;
    } else if (parentscontact.text.length != 11 || !isNumeric(parentscontact.text)) {
      showSnackbar("Invalid contact number.", Colors.red);
      return false;
    } else if (classname.text.trim() == "Select Class") {
      showSnackbar("Select a valid class.", Colors.red);
      return false;
    }
    return true;
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  void showSnackbar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }
}
