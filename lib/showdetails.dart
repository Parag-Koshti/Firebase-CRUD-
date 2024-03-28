import 'package:cloud_firestore/cloud_firestore.dart%20';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igenerate_14/customewidget/widget.dart';

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

    return Scaffold(
      appBar: AppBar(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppWidget.text(
                            title: "Name : " + ds['name'],
                            fontSize: 20,
                            tWeight: FontWeight.w500),
                        AppWidget.text(
                            title: "Mobile no : " + ds['Mobile no'],
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
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            String newName = ds['name'];
                                            String newMobileNo =
                                                ds['Mobile no'];
                                            String newStream = ds['stream'];
                                            String newCourse = ds['course'];

                                            return AlertDialog(
                                              title: Text('Edit Data'),
                                              content: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                      initialValue: newName,
                                                      onChanged: (value) {
                                                        newName = value;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Name',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      initialValue: newMobileNo,
                                                      onChanged: (value) {
                                                        newMobileNo = value;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Mobile no',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      initialValue: newStream,
                                                      onChanged: (value) {
                                                        newStream = value;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Stream',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      initialValue: newCourse,
                                                      onChanged: (value) {
                                                        newCourse = value;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: 'Course',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    updateData(newName, 'name');
                                                    updateData(newMobileNo,
                                                        'Mobile no');
                                                    updateData(
                                                        newStream, 'stream');
                                                    updateData(
                                                        newCourse, 'course');
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Save'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    deleteData();
                                                    Navigator.of(context).pop();
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
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Cancel'),
                                                ),
                                              ],
                                            );
                                          },
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
                                                    Navigator.of(context).pop();
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
                                                    Navigator.of(context).pop();
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
    );
  }
}
