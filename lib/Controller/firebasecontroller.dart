import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createTask(
  String title,
  DateTime start,
  DateTime end,
) async {
  try {
    print('Creating Task....');
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add a new document with a specified ID to a collection
    await firestore.collection('tasks').doc().set({
      'title': title,
      'startime': start,
      'endtime': end,
      'shared': false,
      'completed': false,
    });
    print('###########################');
    print('Task created successfully!');
    print('###########################');
  } catch (e) {
    print('###########################');
    print('Error creating task: $e');
    print('###########################');
    // Handle error
  }
}

Future<void> updateData(
  String title,
  String subtitle,
  String discription,
  String image,
) async {
  // Access Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get the document reference to update
  DocumentReference docRef = firestore.collection('users').doc('DOCUMENT_ID');

  // Update the document
  await docRef.update({'age': 35});

  print('Data updated successfully!');
}

// delete task
Future<void> deleteTask(String title) async {
  // Access Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Get the document reference to delete
  DocumentReference docRef = firestore.collection('tasks').doc(title);

  // Delete the document
  await docRef.delete();

  print('Data deleted successfully!');
}

// Function to read data from Firestore
Future<bool> readTaskData(String email, String password) async {
  try {
    // Access Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Retrieve data from Firestore
    QuerySnapshot querySnapshot = await firestore.collection('tasks').get();

    // Print out the data retrieved for debugging
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      print('Document data: ${document.data()}');
    }

    // Check if any document contains the provided email and password
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      if (data.containsKey('email') &&
          data.containsKey('password') &&
          data['email'] == email &&
          data['password'] == password) {
        return true; // User found
      }
    }

    // User not found
    return false;
  } catch (e) {
    print('Error reading data: $e');
    return false; // Return false if there's an error reading data
  }
}
