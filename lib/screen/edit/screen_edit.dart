import 'dart:developer';
import 'dart:io';
import 'package:database_project/db/functions/dbfunctions.dart';
import 'package:database_project/model/data_model.dart';
import 'package:database_project/screen/edit/editing_student/editing_student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class Editscreen extends StatelessWidget {
  Editscreen({Key? key, required this.student}) : super(key: key);
  studentmodel student;

  final _formKey = GlobalKey<FormState>();
  String? imageAvatar;
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;

  void initState() {
    imageAvatar = student.image;
    _nameController = TextEditingController(text: student.name);
    _ageController = TextEditingController(text: student.age);
    _emailController = TextEditingController(text: student.email);
    _phoneController = TextEditingController(text: student.phone);
  }

  Future pickimage({required BuildContext context}) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    //final imagetemporary = File(image.path);
    // setState(() {
    //   //this.image = imagetemporary;
    imageAvatar = image.path;
    // });

    BlocProvider.of<EditingStudentBloc>(context)
        .add(UpdateEditedImage(updateImage: imageAvatar!));

    log('message');
    //////////////
  }

  Future<void> updateClicked() async {
    final name = _nameController!.text.trim();
    final age = _ageController!.text.trim();
    final email = _emailController!.text.trim();
    final phone = _phoneController!.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        imageAvatar ==null) {
      return;
    }
    // print('$name$age$email$phone');
    final _student = studentmodel(
      name: name,
      age: age,
      email: email,
      phone: phone,
      image: imageAvatar!,
    );

    await editstudent(student.key, _student);
    _nameController!.clear();
    _ageController!.clear();
    _emailController!.clear();
    _phoneController!.clear();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    BlocProvider.of<EditingStudentBloc>(context)
        .add(UpdateEditedImage(updateImage: imageAvatar!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit field'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(38.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                BlocBuilder<EditingStudentBloc, EditingImageState>(
                  builder: (context, state) {
                    return CircleAvatar(
                        radius: 60,
                        // backgroundColor:
                        // Colors.black,
                        backgroundImage: FileImage(File(state.image)));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: () async {
                    await pickimage(context: context);
                    // BlocProvider.of<EditingStudentEvent>(context).
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                // textfield,
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                    prefixIcon: const Icon(Icons.people),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'Name',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Name';
                    }
                    if (!RegExp(
                            r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                        .hasMatch(value)) {
                      return 'Please enter full Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'Age',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter age';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a valid Age';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'E-mail',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter an email";
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    labelText: 'Phone',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter a phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: 60,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black, shape: StadiumBorder()),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateButtonClicked(context: context);
                          }
                        },
                        child: const Text(
                          'Update',
                          // style: TextStyle(color: Colors.white) ,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateButtonClicked({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('UPDATED !!'),
            content: Text('updated successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  child:
                  const Text('cancel');
                  updateClicked();
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => Screenstudent(),
                  //     ));
                },
                child: Text('ok'),
              ),
            ],
          );
        });
  }
}
