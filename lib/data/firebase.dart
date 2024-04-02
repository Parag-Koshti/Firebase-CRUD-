import 'package:cloud_firestore/cloud_firestore.dart ';

class FirestoreService {
  final CollectionReference forms =
      FirebaseFirestore.instance.collection('form');
  Future SaveData(Map<String, dynamic> form, String id) async {
    return await FirebaseFirestore.instance
        .collection("form")
        .doc(id)
        .set(form);
  }

  Future<void> UpdateData(
      String documentId, Map<String, dynamic> updatedData) async {
    await FirebaseFirestore.instance
        .collection('form')
        .doc(documentId)
        .update(updatedData);
  }

  Future<bool> checkDocumentExists(String documentId) async {
    try {
      // Get the document snapshot
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('form')
          .doc(documentId)
          .get();
      // Check if the document exists
      return snapshot.exists;
    } catch (e) {
      // Handle any potential errors
      print('Error checking document existence: $e');
      return false; // Return false if an error occurs
    }
  }
// void updateData(String newValue, String fieldName) async {
//   await FirebaseFirestore.instance
//       .collection('form')
//       .doc(id)
//       .update({fieldName: newValue});
// }
//
// void deleteData() async {
//   await FirebaseFirestore.instance.collection('form').doc(id).delete();
// }

// Future<Stream<QuerySnapshot<Map<String, dynamic>>>> GetData() async {
//   return await FirebaseFirestore.instance.collection('form').snapshots();
// }
}
