import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'staff_creation_page.dart';

class StaffListPage extends StatelessWidget {
  void deleteStaff(String docId) {
    FirebaseFirestore.instance.collection('staff').doc(docId).delete();
  }

  void editStaff(BuildContext context, String docId, String name, String id, String age) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StaffCreationPage(
          docId: docId,
          existingName: name,
          existingId: id,
          existingAge: age,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('staff').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No staff added yet.', style: TextStyle(fontSize: 18, color: Colors.grey)),
            );
          }
          return ListView(
            padding: EdgeInsets.all(10),
            children: snapshot.data!.docs.map((document) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(document['name'][0].toUpperCase(), style: TextStyle(color: Colors.white)),
                  ),
                  title: Text(document['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('ID: ${document['id']} | Age: ${document['age']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          editStaff(
                            context,
                            document.id,
                            document['name'],
                            document['id'],
                            document['age'],
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          deleteStaff(document.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StaffCreationPage()),
          );
        },
        label: Text('Add Staff'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}
