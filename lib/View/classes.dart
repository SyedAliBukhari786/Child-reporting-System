import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class Class extends StatefulWidget {
  const Class({Key? key}) : super(key: key);

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  final TextEditingController _classNameController = TextEditingController();

  Future<void> _addClassToFirebase(String className) async {
    if (className.isNotEmpty) {
      try {
        // Check if a class with the given className already exists
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Classes')
            .where('className', isEqualTo: className)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          // Class with the same className already exists
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Center(child: Text('Class already registered')),
            ),
          );
          return;
        }
        // If class doesn't exist, add it
        await FirebaseFirestore.instance.collection('Classes').add({
          'className': className,
          'TotalStudents': 0,
          'Attendance': 'No',
          'Testslot': 'Available',
          "PresentStudents":0,
          "AbsentStudents": 0,
          "messageperents":"No"
          // Add other fields if needed
        });
       // await FirebaseFirestore.instance.collection('School_Details').doc("ErQ2VcK4nON3TdPFkegQ").update({
         // 'Classes': FieldValue.increment(1),
        //});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Center(child: Text('Class added successfully')),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Center(child: Text('$e')),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Center(child: Text('Enter Class Name')),
        ),
      );
    }
  }




  Future<void> _updateClassName(String documentId, String currentClassName) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Update Class Name')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _classNameController..text = currentClassName,
                decoration: InputDecoration(
                  labelText: 'New Class Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String newClassName = _classNameController.text.trim();

                  if (newClassName.isNotEmpty && newClassName != currentClassName) {
                    try {
                      // Check if a class with the newClassName already exists
                      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                          .collection('Classes')
                          .where('className', isEqualTo: newClassName)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        // Class with the newClassName already exists
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Center(child: Text('Class name already exists')),
                          ),
                        );
                        return;
                      }

                      // Update the class name
                      await FirebaseFirestore.instance.collection('Classes').doc(documentId).update({
                        'className': newClassName,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Center(child: Text('Class name updated successfully')),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Center(child: Text('$e')),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Center(child: Text('Enter a valid class name')),
                      ),
                    );
                  }
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Update'),
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(

            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Center(
                    child: Container(
                      height: 200,
                      child: Lottie.asset("assets/classes.json"),
                    ),
                  ),
                  Text("Total Classes", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 22),),
                  SizedBox(height: 10),
                  Expanded(

                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('Classes').orderBy("className",descending: false).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final classes = snapshot.data!.docs;
                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                            ),
                            itemCount: classes.length,
                            itemBuilder: (context, index) {
                              var classData = classes[index].data() as Map<String, dynamic>;
                              var className = classData['className'];
                              var totalStudents = classData['TotalStudents'];
                              var documentId = classes[index].id;

                              return GestureDetector(onTap: () {
                                _updateClassName(documentId, classData['className']);

                              },
                                child: Container(

                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        className,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),

                                      SizedBox(height: 8),
                                      Column(
                                        children: [
                                          Text('Total Students'),
                                          SizedBox(height: 2),
                                          Text('$totalStudents', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, ),),

                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Add Class')),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _classNameController,
                        decoration: InputDecoration(
                          labelText: 'Class Name',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _addClassToFirebase(_classNameController.text.trim());
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
