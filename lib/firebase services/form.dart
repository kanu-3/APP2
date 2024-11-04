import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task2/firebase%20services/login.dart';
import 'package:task2/util/util.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {

File? _image;
String? selectedGender;
String? selectedBranch;
String? selectedSection;
String? selectedSkills;
  
  final picker=ImagePicker();
  final nameController = TextEditingController();
  final photoController = TextEditingController();
  final rollNumberController = TextEditingController();
  final studentNumberController = TextEditingController();

  bool loading=false;

  Future<void> Image() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  Future<void> Uploadimage() async{
    if(_image==null)
    return;

    try{
      final storageref=FirebaseStorage.instance.ref("image");
      await storageref.putFile(_image!);
    }catch(e){
      Util().toastMessage("error occured: $e");
    }
  }

  void submitform(){
    if(nameController.text.isEmpty || rollNumberController.text.isEmpty || studentNumberController.text.isEmpty){
      Util().toastMessage("all fields are mandatory");
      return;
    }
    int length = studentNumberController.text.length;
    if(length<=7){
      Util().toastMessage("Student number must be exactly of 7 digits");
      return;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student's profile form"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: 
          AssetImage("assets/images/bgimageform.jpeg"),fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0,left: 20,right: 20,bottom: 10),
          child: Container(
            height: 660,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Student's profile form",style: TextStyle(
                      fontWeight: FontWeight.w900,fontSize: 40
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: photoController,
                      decoration: InputDecoration(
                        label: Text("Upload profile picture"),
                        helperText: "max:100kb",
                        hintText: "no file uploaded",
                        border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: (){
                    Image();
                  }, child: Text("pick image")),
                  IconButton(onPressed: (){
                    Uploadimage();
                  }, icon: Icon(Icons.upload_file_outlined)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        label: Text("Full Name"),
                        border: OutlineInputBorder()
                      ),
                      inputFormatters: [
                       FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), 
                      ],
                    ),
                    
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text("Roll number"),
                        border: OutlineInputBorder()
                      ),
                      maxLength: 13,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                        decoration: InputDecoration(
                          helperText: "must be exactly 7 characters",
                          label: Text("Student number"),
                          border: OutlineInputBorder()
                        ),
                        maxLength: 7,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                                      ),
                      ),),
                     Expanded(child: Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: DropdownButtonFormField(
                       value:selectedBranch,
                       decoration: InputDecoration(
                        label: Text("Branch"),
                        border: OutlineInputBorder(),
                        helperText: "select from below"
                       ),
                       items: [
                        DropdownMenuItem(value: "CSE",child: Text("CSE"),),
                        DropdownMenuItem(value: "CSE (AIML)",child: Text("CSE (AIML)"),),
                        DropdownMenuItem(value: "CSE (DS)",child: Text("CSE (DS)"),),
                        DropdownMenuItem(value: "ECE",child: Text("ECE"),),
                       ], onChanged: (value){
                        setState(() {
                          selectedBranch=value;
                        });
                       },
                       validator:(value){
                        if(value==null){
                          return ("please select a branch");
                        }
                        return null;
                       },
                       ),
                     ),
                     ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonFormField(
                       value:selectedSection,
                       decoration: InputDecoration(
                        label: Text("Section"),
                        border: OutlineInputBorder(),
                        helperText: "select from below"
                       ),
                       items: [
                        DropdownMenuItem(value: "1",child: Text("1"),),
                        DropdownMenuItem(value: "2",child: Text("2"),),
                        DropdownMenuItem(value: "3",child: Text("3"),),
                       ], onChanged: (value){
                        setState(() {
                          selectedSection=value;
                        });
                       },
                       validator:(value){
                        if(value==null){
                          return ("please select a section");
                        }
                        return null;
                       },
                       ),
                      ),),
                     Expanded(child: Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: DropdownButtonFormField(
                       value:selectedSkills,
                       decoration: InputDecoration(
                        label: Text("Skills"),
                        border: OutlineInputBorder(),
                        helperText: "select from below"
                       ),
                       items: [
                        DropdownMenuItem(value: "App developer",child: Text("App developer"),),
                        DropdownMenuItem(value: "Web developer",child: Text("Web developer"),),
                        DropdownMenuItem(value: "DSA",child: Text("DSA"),),
                        DropdownMenuItem(value: "Cloud computing",child: Text("Cloud computing"),),
                        DropdownMenuItem(value: "Machine learning",child: Text("Machine learning"),),
                       ], onChanged: (value){
                        setState(() {
                          selectedSkills=value;
                        });
                       },
                       validator:(value){
                        if(value==null){
                          return ("atleast one skill must be selected");
                        }
                        return null;
                       },
                       ),
                     ),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Gender:"),
                        Radio<String>(value: "Male", groupValue: selectedGender, onChanged: (value){
                          setState(() {
                            selectedGender=value;
                          });
                        },
                        ),
                        Text("Male"),
                        Radio<String>(value: "Female", groupValue: selectedGender, onChanged: (value){
                          setState(() {
                            selectedGender=value;
                          });
                        },
                        ),
                        Text("Female"),
                        Radio<String>(value: "Other", groupValue: selectedGender, onChanged: (value){
                          setState(() {
                            selectedGender=value;
                          });
                        },
                        ),
                        Text("Other"),
                      ],
                    ),
                  ),
                  ElevatedButton(onPressed: submitform, child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}