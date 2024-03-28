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
