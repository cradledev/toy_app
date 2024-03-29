import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/helper/theme_helper.dart';
import 'package:toy_app/service/user_auth.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:toy_app/provider/index.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPage();
}

class _AddressPage extends State<AddressPage> {
  // app state
  AppState _appState;
  final _formKey = GlobalKey<FormState>();
  var savedFirstName = TextEditingController();
  var savedLastName = TextEditingController();
  // TextEditingController userEmailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  // TextEditingController address2Controller = TextEditingController();
  // TextEditingController zipcodeController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final picker = ImagePicker();
  final userService = UserService();
  // List<dynamic> country_items = [];
  String imagePath = '';
  int selectedCounty = 234;
  bool isProcessing = false;
  @override
  void initState() {
    super.initState();
    _appState = Provider.of<AppState>(context, listen: false);
    getUserInfo();
  }

  void getUserInfo() async {
    SharedPreferences savedPref = await SharedPreferences.getInstance();
    savedFirstName.text = _appState.firstName;
    savedLastName.text = _appState.lastName;
    // userEmailController.text = _appState.user.userEmail;
    cityController.text = _appState.profileCity;
    address1Controller.text = _appState.profileAddress1;
    phoneNumber.text = _appState.phoneNumber ?? "";
    imagePath = (savedPref.getString('path') ?? "");
    setState(() {});
    // if (mounted) {
    //   var _countryItemsRes = await http.get(
    //     Uri.parse(
    //         "$backendEndpoint/Country/GetAllCountries?languageId=0&showHidden=false"),
    //     headers: {
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'Access-Control-Allow-Origin': '*',
    //       "Authorization": "Bearer ${_appState.user.token}"
    //     },
    //   );
    //   print(_countryItemsRes);
    //   // print(_country_items_res.body);
    //   setState(() {
    //     country_items = jsonDecode(_countryItemsRes.body);
    //     imagePath = (savedPref.getString('path') ?? "");
    //     selectedCounty = _appState.countryId == 0 ? 234 : _appState.countryId;
    //   });
    // }
  }

  void submitInfo() async {
    final bool isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      var list = {
        'firstname': savedFirstName.text,
        'lastname': savedLastName.text,
        'userEmail': _appState.user.userEmail,
        'country_id': selectedCounty,
        'city': cityController.text,
        'address1': address1Controller.text,
        'phone': phoneNumber.text,
        'bio': _appState.bio == null ? "" : _appState.bio['default_value']
      };
      list['avatar'] = imagePath;
      print(list);
      setState(() {
        isProcessing = true;
      });
      try {
        String response = await userService.userinfoChange(list, _appState.bio);
        setState(() {
          isProcessing = false;
        });
        if (response == 'success') {
          Navigator.pushNamed(context, '/profile');
        }
      } catch (e) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(bottom: 25),
          color: const Color(0xffffffff),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                             AppLocalizations.of(context).profilepage_address,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: savedFirstName,
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              lableText:
                                                  AppLocalizations.of(context)
                                                      .editpage_firstname),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return AppLocalizations.of(context)
                                              .editpage_pfirstname;
                                        }
                                        // Return null if the entered email is valid
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: savedLastName,
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              lableText:
                                                  AppLocalizations.of(context)
                                                      .editpage_lastname),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return AppLocalizations.of(context)
                                              .editpage_plastname;
                                        }
                                        // Return null if the entered email is valid
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     TextFormField(
                                //       controller: userEmailController,
                                //       decoration: ThemeHelper()
                                //           .textInputDecoration(
                                //               lableText:
                                //                   AppLocalizations.of(context)
                                //                       .login_email),
                                //       validator: (value) {
                                //         if (value == null ||
                                //             value.trim().isEmpty) {
                                //           return AppLocalizations.of(context)
                                //               .login_pmail;
                                //         }
                                //         // Check if the entered email has the right format
                                //         if (!RegExp(r'\S+@\S+\.\S+')
                                //             .hasMatch(value)) {
                                //           return AppLocalizations.of(context)
                                //               .login_pvmail;
                                //         }
                                //         // Return null if the entered email is valid
                                //         return null;
                                //       },
                                //       onChanged: (value) {},
                                //       keyboardType: TextInputType.emailAddress,
                                //     ),
                                //     const SizedBox(
                                //       height: 30,
                                //     )
                                //   ],
                                // ),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     const Text(
                                //       "Country",
                                //       style: TextStyle(
                                //           fontSize: 15,
                                //           fontWeight: FontWeight.w400,
                                //           color: Colors.black87),
                                //     ),
                                //     const SizedBox(
                                //       height: 5,
                                //     ),
                                //     DropdownButton(
                                //       value: selectedCounty,
                                //       items: country_items?.map((item) {
                                //         return DropdownMenuItem<int>(
                                //           child: Text('${item["name"]}'),
                                //           value: item['id'],
                                //         );
                                //       })?.toList(),
                                //       onChanged: (value) {
                                //         print(value);
                                //         setState(() {
                                //           selectedCounty = value;
                                //         });
                                //       },
                                //       hint: const Text("Select Country"),
                                //       disabledHint: const Text("Disabled"),
                                //       elevation: 8,
                                //       style: const TextStyle(
                                //           color: Colors.black, fontSize: 16),
                                //       icon: const Icon(
                                //           Icons.arrow_drop_down_circle),
                                //       iconDisabledColor: Colors.red,
                                //       // iconEnabledColor: Colors.green,
                                //       isExpanded: true,
                                //     ),
                                //   ],
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: cityController,
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              lableText:
                                                  AppLocalizations.of(context)
                                                      .register_city),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: address1Controller,
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              lableText:
                                                  AppLocalizations.of(context)
                                                      .street_address),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      controller: phoneNumber,
                                      decoration: ThemeHelper()
                                          .textInputDecoration(
                                              lableText:
                                                  AppLocalizations.of(context)
                                                      .phone_numebr),
                                      keyboardType: TextInputType.phone,
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: width * 0.9,
                child: ElevatedButton(
                  onPressed: isProcessing
                      ? null
                      : () {
                          submitInfo();
                        },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff283488)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(83.0),
                        side: const BorderSide(color: Color(0xff283488)),
                      ),
                    ),
                  ),
                  child: Text(
                    isProcessing
                        ? "...processing"
                        : AppLocalizations.of(context).editpage_save,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
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
