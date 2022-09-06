import 'dart:io';
import 'package:database_project/db/functions/dbfunctions.dart';
import 'package:database_project/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Screenadd extends StatefulWidget {
  Screenadd({Key? key}) : super(key: key);

  @override
  State<Screenadd> createState() => _ScreenaddState();
}

class _ScreenaddState extends State<Screenadd> {
  final _formKey = GlobalKey<FormState>();
  // File? image;
  String? imageAvatar;

  Future pickimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    //final imagetemporary = File(image.path);
    setState(() {
      //this.image = imagetemporary;
      this.imageAvatar = image.path;
    });
  }

  final _namecontroller = TextEditingController();

  final _agecontroller = TextEditingController();

  final _emailcontroller = TextEditingController();

  final _phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget textfield = TextFormField(
      controller: _namecontroller,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.people),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        labelText: 'Name',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter Name';
        }
        if (!RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
            .hasMatch(value)) {
          return 'Please enter full Name';
        }
        return null;
      },
    );

    return Center(
      child: Padding(
        padding: EdgeInsets.all(38.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CircleAvatar(
                radius: 60,
                // backgroundColor: Colors.black,
                backgroundImage: (imageAvatar != null)
                    ? FileImage(File(imageAvatar!))
                    : AssetImage('lib/asset/addin2.webp') as ImageProvider,
              ),
              InkWell(
                onTap: () {
                  pickimage();
                },
                child: const Icon(
                  Icons.add_a_photo_sharp,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              textfield,

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _agecontroller,
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
                controller: _emailcontroller,
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
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'please enter Email';
                //   }
                // },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phonecontroller,
                decoration: InputDecoration(
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
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 60,
                    width: 200,
                    child: RaisedButton(
                      color: Colors.black87,
                      onPressed: () {
                        // StudentListButtonClicked();
                        if (_formKey.currentState!.validate()) {
                          StudentListButtonClicked();
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Adding Data...'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black)),
                    ),
                  )),
              // ElevatedButton(onPressed: (){}, child: );
            ],
          ),
        ),
      ),
    );
  }

  Future<void> StudentListButtonClicked() async {
    final name = _namecontroller.text.trim();
    final age = _agecontroller.text.trim();
    final email = _emailcontroller.text.trim();
    final phone = _phonecontroller.text.trim();

    if (name.isEmpty || age.isEmpty || email.isEmpty || phone.isEmpty) {
      return;
    }
    // print('$name$age$email$phone');
    final _student = studentmodel(
        name: name, age: age, email: email, phone: phone, image: imageAvatar!);

    addStudent(_student);
    _namecontroller.clear();
    _agecontroller.clear();
    _emailcontroller.clear();
    _phonecontroller.clear();
  }
}
