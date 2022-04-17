import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/service/user_auth.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Edit extends StatefulWidget {
  const Edit({Key key}) : super(key: key);

  @override
  State<Edit> createState() => _Edit();
}

class _Edit extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  var savedFirstName = TextEditingController();
  var savedLastName = TextEditingController();
  var savedBio = TextEditingController();
  final picker = ImagePicker();
  final userService = UserService();
  File _image;
  String imagePath = '';
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    setState(() {
      savedFirstName.text = (savedPref.getString('first_name') ?? "");
      savedLastName.text = (savedPref.getString('last_name') ?? "");
      savedBio.text = (savedPref.getString('bio') ?? "");
      imagePath = (savedPref.getString('path') ?? "");
    });
  }

  void submitInfo() async {
    final bool isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      List<String> list = [];
      list.add(savedFirstName.text);
      list.add(savedLastName.text);
      list.add(savedBio.text);
      if (_image = null) {
        list.add(_image.path);
      } else {
        list.add(imagePath);
      }
      String response = await userService.userinfoChange(list);

      if (response == 'success') {
        Navigator.pushNamed(context, '/profile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Future getImage() async {
      var pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile = null) {
          _image = File(pickedFile.path);
          // print('hahaha');
        } else {
          print('No image selected.');
        }
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: Image.asset(
          'assets/img/LoginRegistration/header.png',
          // height: height * 0.1,
          width: width * 0.5,
          fit: BoxFit.cover,
        ),
        leadingAction: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: const LanguageTransitionWidget(),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 25),
          color: const Color(0xffffffff),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      AppLocalizations.of(context).editpage_text1,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).editpage_text2,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff999999),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width * 0.3,
                height: height * 0.2,
                margin:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: getImage,
                  child: CircleAvatar(
                    radius: 38.0,
                    child: ClipOval(
                      child: _image == null
                          ? (imagePath == ''
                              ? Image.asset(
                                  "assets/img/home/avatar.jpg",
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  File(imagePath),
                                  fit: BoxFit.fill,
                                ))
                          : Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .editpage_firstname,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: savedFirstName,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .editpage_pfirstname;
                                            }
                                            // Return null if the entered email is valid
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .editpage_lastname,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: savedLastName,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return AppLocalizations.of(
                                                      context)
                                                  .editpage_plastname;
                                            }
                                            // Return null if the entered email is valid
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)
                                              .editpage_bio,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextField(
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.07,
                        width: width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {
                            submitInfo();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff283488)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(83.0),
                                side:
                                    const BorderSide(color: Color(0xff283488)),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context).editpage_save,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
