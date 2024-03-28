import 'package:flutter/material.dart';

import 'package:igenerate_14/data/firebase.dart';
import 'package:igenerate_14/showdetails.dart';
import 'package:random_string/random_string.dart';

import 'model/branch.dart';
import 'model/course.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  String? res1;
  String? res2;
  String? streamsname;
  String? courseId;

  @override
  void initState() {
    super.initState();
  }

  List<Branch>? branchMaster = [
    Branch(id: "1", name: "Account"),
    Branch(id: "2", name: "IT")
  ];
  List<Course>? courseStore = [];
  List<Course>? courseMaster = [
    Course(id: "1", name: "B.com", parentId: "1"),
    Course(id: "2", name: "M.com", parentId: "1"),
    Course(id: "3", name: "CA", parentId: "1"),
    Course(id: "4", name: "BCA", parentId: "2"),
    Course(id: "5", name: "MCA", parentId: "2"),
    Course(id: "6", name: "B.Tech", parentId: "2"),
  ];
  String? selectedBranch = 'Please choose a Branch';
  String? selectedCourse = 'Please choose a Course';

  @override
  Widget build(BuildContext context) {
    // ),
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text("Form"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "Enter Your Name",
                        label: Text("Name"),
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "Enter Your Number",
                        label: Text("Mobile No."),
                        prefixIcon: Icon(Icons.call)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(Icons.school_outlined)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Branch>(
                        isDense: true,
                        hint: Text('Select a branch'),
                        value: branchMaster!.firstWhere(
                            (element) => element.name == selectedBranch,
                            orElse: () => branchMaster!.first),
                        // Initially none is selected
                        onChanged: (Branch? newValue) {
                          // Handle dropdown value change
                          courseStore!.clear();
                          setState(() {
                            if (newValue != null) {
                              selectedBranch = newValue!.name!;
                              print('Selected branch: ${newValue.name}');

                              courseStore!.addAll(courseMaster!.where(
                                  (element) =>
                                      element.parentId == newValue.id));
                              print('c length ${courseStore!.length}');
                            }
                          });
                        },
                        items: branchMaster!
                            .map<DropdownMenuItem<Branch>>((Branch branch) {
                          return DropdownMenuItem<Branch>(
                            value: branch,
                            child: Text(branch.name!),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        prefixIcon: Icon(Icons.book)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Course>(
                        isDense: true,
                        hint: Text('Select a course'),
                        value: courseStore!.firstWhere(
                            (element) => element.name == selectedCourse,
                            orElse: () => courseStore!.isEmpty
                                ? courseMaster!.first
                                : courseStore!.first),
                        // Initially none is selected
                        onChanged: (Course? newValue) {
                          // Handle dropdown value change
                          setState(() {
                            if (newValue != null) {
                              selectedCourse = newValue.name!;
                              print('Selected branch: ${newValue.name}');
                            }
                          });

                          //
                        },
                        items: courseStore!
                            .map<DropdownMenuItem<Course>>((Course course) {
                          return DropdownMenuItem<Course>(
                            value: course,
                            child: Text(course.name!),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () async {
                      String Id = randomAlphaNumeric(10);
                      Map<String, dynamic> form = {
                        "stream": selectedBranch,
                        "course": selectedCourse,
                        "name": nameController.text,
                        "Id": Id,
                        "Mobile no": phoneController.text,
                      };
                      nameController.clear();
                      phoneController.clear();
                      await FirestoreService().SaveData(form, Id);
                    },
                    child: Text("Save"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowDetails(),
                          ));
                    },
                    child: Text("Show Details"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
