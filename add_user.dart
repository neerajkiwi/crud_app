import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_sharedprefernece/providers/user_provider.dart';
import 'package:login_sharedprefernece/user.dart';
import 'package:provider/provider.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final formkey = GlobalKey<FormState>();
  XFile? image;

  final ImagePicker _picker = ImagePicker();

  void pickImage(ImageSource source) async {
    final XFile? selectedimage = await _picker.pickImage(source: source);

    if (selectedimage != null) {
      setState(() {
        image = selectedimage;
      });
    }
    Navigator.pop(context);
  }

  TextEditingController newusername = TextEditingController();
  TextEditingController newuserid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New User',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80.0,
                        backgroundImage: (image != null)
                            ? FileImage(File(image!.path))
                            : const AssetImage('images/index.png')
                                as ImageProvider,
                      ),
                      Positioned(
                        bottom: 20.0,
                        right: 20.0,
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()));
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 28.0,
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: newusername,
                  decoration: const InputDecoration(hintText: " Enter Name "),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return " required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      backgroundColor: Colors.grey,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        var newUser = User(
                            id: widget.id,
                            name: newusername.text,
                            userFileImagePath:
                                image?.path != null ? File(image!.path) : null,
                            isBlocked: false);
                        Provider.of<UserProvider>(context, listen: false)
                            .addUser(newUser);

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              // onPressed: () async {
              //   final XFile? image =
              //       await _picker.pickImage(source: ImageSource.camera);
              // },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              // onPressed: () async {
              //   final XFile? image =
              //       await _picker.pickImage(source: ImageSource.gallery);
              // },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }
}
