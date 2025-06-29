import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffCreationPage extends StatefulWidget {
  final String? docId;
  final String? existingName;
  final String? existingId;
  final String? existingAge;

  StaffCreationPage({
    this.docId,
    this.existingName,
    this.existingId,
    this.existingAge,
  });

  @override
  _StaffCreationPageState createState() => _StaffCreationPageState();
}

class _StaffCreationPageState extends State<StaffCreationPage> {
  late TextEditingController nameController;
  late TextEditingController idController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.existingName ?? '');
    idController = TextEditingController(text: widget.existingId ?? '');
    ageController = TextEditingController(text: widget.existingAge ?? '');
  }

  void addOrUpdateStaff() {
    if (widget.docId == null) {
      // Add new staff
      FirebaseFirestore.instance
          .collection('staff')
          .add({
            'name': nameController.text,
            'id': idController.text,
            'age': ageController.text,
          })
          .then((value) {
            Navigator.pop(context);
          });
    } else {
      // Update existing staff
      FirebaseFirestore.instance
          .collection('staff')
          .doc(widget.docId)
          .update({
            'name': nameController.text,
            'id': idController.text,
            'age': ageController.text,
          })
          .then((value) {
            Navigator.pop(context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.docId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Staff' : 'Add Staff'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    isEdit ? 'Edit Staff Details' : 'Enter Staff Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.badge),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.cake),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 25),
                  ElevatedButton.icon(
                   onPressed: addOrUpdateStaff,
                    icon: Icon(isEdit ? Icons.update : Icons.save),
                    label: Text(isEdit ? 'Update' : 'Submit'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor:
                          Colors.white, // ✅ Ensure text/icon are visible
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ), 
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
