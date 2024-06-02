import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentDetails extends StatefulWidget {
  final String className;

  const StudentDetails({Key? key, required this.className}) : super(key: key);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Students')
          .where('Class', isEqualTo: widget.className)
          .get();

      setState(() {
        students = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students in ${widget.className}'),
      ),
      body: students.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(students[index]['StudentName'] ?? 'No Name'),
                  subtitle:
                      Text('Roll No: ${students[index]['Rollno'] ?? 'N/A'}'),
                  onTap: () {
                    // You can add further navigation to student details here
                  },
                );
              },
            ),
    );
  }
}
