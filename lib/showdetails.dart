import 'package:cloud_firestore/cloud_firestore.dart%20';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igenerate_14/customewidget/widget.dart';

import 'home.dart';

class ShowDetails extends StatefulWidget {
  const ShowDetails({super.key});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final fireStore = FirebaseFirestore.instance.collection('form').snapshots();
    // String? selectedBranch = 'Please choose a Branch';
    // String? selectedCourse = 'Please choose a Course';

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text("Form details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("form").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // or any other loading indicator
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Text(
                    'No data available'); // or any other UI indicating no data
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  void updateData(String newValue, String fieldName) async {
                    await FirebaseFirestore.instance
                        .collection('form')
                        .doc(ds.id)
                        .update({fieldName: newValue});
                  }

                  // Function to delete data from Firestore
                  void deleteData() async {
                    await FirebaseFirestore.instance
                        .collection('form')
                        .doc(ds.id)
                        .delete();
                  }

                  return Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppWidget.text(
                              title: "Name : " + ds['name'],
                              fontSize: 20,
                              tWeight: FontWeight.bold),
                          AppWidget.text(
                              title: "countryCode : " + ds['countryCode'],
                              fontSize: 20,
                              tWeight: FontWeight.w500),
                          AppWidget.text(
                              title: "Mobile no : " + ds['phoneNumber'],
                              fontSize: 20,
                              tWeight: FontWeight.w500),
                          AppWidget.text(
                              title: "Stream : " + ds['stream'],
                              fontSize: 20,
                              tWeight: FontWeight.w500),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppWidget.text(
                                  title: "Course : " + ds['course'],
                                  fontSize: 20,
                                  tWeight: FontWeight.w500),
                              Container(
                                child: Row(
                                  children: [
                                    IconButton.filledTonal(
                                        color: Colors.pink,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                name: ds['name'],
                                                countryCode: ds['countryCode'],
                                                phoneNumber: ds['phoneNumber'],
                                                dropdown1: ds['stream'],
                                                dropdown2: ds['course'],
                                                id: ds['Id'],
                                                flag: true,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit)),
                                    IconButton.filledTonal(
                                        color: Colors.pink,
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Confirm Delete'),
                                                content: Text(
                                                    'Are you sure you want to delete this entry?'),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      deleteData();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                        Colors.red,
                                                      ),
                                                    ),
                                                    child: Text('Delete'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.delete_forever))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
