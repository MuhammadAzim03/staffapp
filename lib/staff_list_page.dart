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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Staff List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('staff').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No staff added yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView(
            padding: EdgeInsets.all(16),
            children: snapshot.data!.docs.map((document) {
              final name = document['name']?.toString() ?? '';
              final id = document['id']?.toString() ?? '';
              final age = document['age']?.toString() ?? '';

              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.primaryColor.withOpacity(0.4)),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.primaryColor,
                    child: Text(
                      (name.isNotEmpty)
                          ? name[0].toUpperCase()
                          : '?',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    'ID: $id | Age: $age',
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          editStaff(
                            context,
                            document.id,
                            name,
                            id,
                            age,
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
      ),
    );
  }
}
