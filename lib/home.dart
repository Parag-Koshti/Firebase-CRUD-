import 'package:flutter/material.dart';
import 'package:igenerate_14/data/firebase.dart';
import 'package:igenerate_14/showdetails.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:random_string/random_string.dart';

import 'model/branch.dart';
import 'model/course.dart';

class HomePage extends StatefulWidget {
  String? name;
  // String? mobileno;
  String? phoneNumber;
  String? countryCode;
  String? dropdown1;
  String? dropdown2;
  String? id;
  bool? flag;

  HomePage(
      {Key? mykey,
      this.id,
      this.phoneNumber,
      this.countryCode,
      this.flag,
      this.name,
      // this.mobileno,
      this.dropdown1,
      this.dropdown2})
      : super(key: mykey);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();

  String? res1;
  String? res2;
  String? streamsname;
  String? courseId;
  String? number;
  String? cCode;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.name ?? '';
    phoneController.text = widget.phoneNumber ?? '';
    setState(() {
      cCode = widget.countryCode ?? '';
      print('c code :  $cCode');
    });

    if (widget.flag == true) {
      // Editing existing data, set initial values
      selectedBranch = widget.dropdown1 ?? 'Please choose a Branch';
      selectedCourse = widget.dropdown2 ?? 'Please choose a Course';
      // Set initialCountryCode for editing existing data
      phoneController.text = widget.phoneNumber ?? '';
    } else {
      // Adding new data, set default values
      selectedBranch = 'Please choose a Branch';
      selectedCourse = 'Please choose a Course';
    }

    // Populate courseStore based on the selected branch
    branchMaster!.forEach((branch) {
      if (branch.name == selectedBranch) {
        courseStore!.addAll(
            courseMaster!.where((course) => course.parentId == branch.id));
      }
    });
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
  String? bid;
  @override
  Widget build(BuildContext context) {
    // ),
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: TextFormField(
                //     controller: phoneController,
                //     keyboardType: TextInputType.phone,
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(15)),
                //         hintText: "Enter Your Number",
                //         label: Text("Mobile No."),
                //         prefixIcon: Icon(Icons.call)),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(20),
                //   child: IntlPhoneField(
                //     keyboardType: TextInputType.phone,
                //     controller: phoneController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       hintText: "Enter Mobile no",
                //       label: Text("Mobile no"),
                //     ),
                //     dropdownIconPosition: IconPosition.trailing,
                //     disableLengthCheck: true,
                //     flagsButtonPadding: EdgeInsets.all(5),
                //     flagsButtonMargin: EdgeInsets.all(5),
                //     initialValue: res1,
                //     initialCountryCode: res2,
                //     onChanged: (phone) {
                //       setState(() {
                //         // Set countryCode and mobileno
                //         widget.countryCode = phone.countryCode;
                //         widget.mobileno = phone.number;
                //       });
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IntlPhoneField(
                    // initialCountryCode: "IN",
                    initialValue: cCode,
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Enter Mobile no",
                      label: Text("Mobile no"),
                    ),
                    dropdownIconPosition: IconPosition.leading,
                    flagsButtonPadding: EdgeInsets.all(5),
                    flagsButtonMargin: EdgeInsets.all(5),
                    onCountryChanged: (value) {
                      setState(() {
                        widget.countryCode = value.dialCode;
                        print('change  code :  ${widget.countryCode}');
                      });
                    },
                    onChanged: (phone) {
                      // phoneController.text = phone.completeNumber;
                      setState(() {
                        widget.phoneNumber = phone.number;
                      });
                      print('change  code :  ${widget.countryCode}');
                    },
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
                      if (widget.flag == true) {
                        // Update existing document
                        String idToUpdate = widget.id ??
                            ''; // Use existing ID or empty string if not available
                        Map<String, dynamic> updatedData = {
                          "name": nameController.text,
                          "countryCode":
                              widget.countryCode, // Updated to use countryCode
                          "phoneNumber":
                              widget.phoneNumber, // Updated to use phoneNumber
                          "stream": selectedBranch!,
                          "course": selectedCourse!,
                        };
                        print(widget.countryCode);
                        nameController.clear();
                        phoneController.clear();
                        setState(() {
                          selectedBranch = 'Please choose a Branch';
                          selectedCourse = 'Please choose a Course';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data Updated Suessfully')));
                        await FirestoreService()
                            .UpdateData(idToUpdate, updatedData);
                      } else {
                        // Save new document
                        String newId = randomAlphaNumeric(
                            10); // Generate new ID for the new document
                        Map<String, dynamic> data = {
                          "countryCode": widget.countryCode,
                          "phoneNumber": widget.phoneNumber, // Use phoneNumber
                          "stream": selectedBranch,
                          "course": selectedCourse,
                          "name": nameController.text,
                          "Id": newId,
                        };
                        await FirestoreService().SaveData(data, newId);
                        nameController.clear();
                        phoneController.clear();
                        setState(() {
                          selectedBranch = 'Please choose a Branch';
                          selectedCourse = 'Please choose a Course';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Data saved Suessfully')));
                      }
                    },
                    child: Text(widget.flag == true ? "UPDATE" : "SAVE"),
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
