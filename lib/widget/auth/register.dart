import 'package:flutter/material.dart';
import 'package:toy_app/components/components.dart';
import 'package:toy_app/service/user_auth.dart';
import 'package:toy_app/service/mailchimp_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:convert';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  // user service
  late UserService userService;
  late MailChimpService mailChimpService;
  // page slide setting
  final int _numPages = 2;
  final PageController _pageController = PageController(initialPage: 0);
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  int _currentPage = 0;
  bool? isValid = false;
  bool? isValid1 = false;
  // form setting
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _confirmpassword = '';
  List<String> info = [];
  // loading status
  late bool _loadingStatus = false;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    _loadingStatus = false;
    userService = UserService();
    mailChimpService = MailChimpService();
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return list;
  }

  void _onNextPage() {
    _checkValidation();
    if (_currentPage != _numPages - 1) {
      if (isValid == true) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    } else {
      if (isValid1 == true) {
        _formKey1.currentState?.save();
        // print(1);
        submitRegister();
      }
    }
  }

  void _checkValidation() {
    isValid = _formKey.currentState?.validate();
    isValid1 = _formKey1.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();
    }
    if (isValid1 == true) {
      _formKey1.currentState?.save();
    }
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 35.0 : 8.0,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  void submitRegister() async {
    setState(() {
      _loadingStatus = true;
    });
    Future.delayed(const Duration(seconds: 4), () {
      mailChimpService.addContact(_email, _firstName, _lastName).then((data) {
        var body = jsonDecode(data.body);
        // setState(() {
        //   _loadingStatus = false;
        // });
        // if (data.statusCode == 200) {
        //   setState(() {
        //     _loadingStatus = false;
        //   });
        //   Navigator.pushReplacementNamed(context, '/home');
        // }
        setState(() {
          _loadingStatus = false;
        });
        Navigator.pushReplacementNamed(context, '/home');
      }).catchError((onError) {
        print(onError);
        setState(() {
          _loadingStatus = false;
        });
        Navigator.pushReplacementNamed(context, '/home');
      });
    });
    // info.add(_firstName);
    // info.add(_lastName);
    // info.add(_email);
    // info.add(_password);
    // String response = await userService.register(info);
    // if (response == 'success') {
    //   setState(() {
    //     _loadingStatus = false;
    //   });
    //   Navigator.pushReplacementNamed(context, '/home');
    // }
    // setState(() {
    //   _loadingStatus = false;
    // });
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Padding(
        padding: EdgeInsets.zero,
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              // padding: EdgeInsets.zero,
              // height: MediaQuery.of(context).size.height * 0.7,
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
                  _checkValidation();
                  if (isValid == false && _currentPage == 0) {
                    // _pageController.jumpTo(0);
                    _pageController.jumpToPage(0);
                  } else {
                    setState(() {
                      _currentPage = page;
                    });
                  }
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            AppLocalizations.of(context)!.register_create,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.register_description1,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xff999999),
                              height: 1.2,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.register_description2,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xff999999),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .register_fname,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .register_fname,
                                          hintStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .register_pfname;
                                          }
                                          // Return null if the entered email is valid
                                          return null;
                                        },
                                        controller: _firstnameController,
                                        onChanged: (value) {
                                          setState(() {
                                            _firstName = value;
                                          });
                                        },
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .register_lname,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .register_lname,
                                          hintStyle: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey)),
                                        ),
                                        controller: _lastnameController,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .register_plname;
                                          }
                                          // Return null if the entered email is valid
                                          return null;
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _lastName = value;
                                          });
                                        },
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
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 100,
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .registeremail_caccount,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .registeremail_description1,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff999999),
                                height: 1.2,
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.registeremail_tap,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color(0xff999999),
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .registeremail_email,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
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
                                                      context)!
                                                  .registeremail_pmail;
                                            }
                                            // Check if the entered email has the right format
                                            if (!RegExp(r'\S+@\S+\.\S+')
                                                .hasMatch(value)) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .registeremail_vmail;
                                            }
                                            // Return null if the entered email is valid
                                            return null;
                                          },
                                          controller: _emailController,
                                          onChanged: (value) {
                                            setState(() {
                                              _email = value;
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .registeremail_pwd,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
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
                                          controller: _passwordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .registeremail_ppwd;
                                            }
                                            if (value.trim().length < 8) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .registeremail_lpwd;
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _password = value;
                                            });
                                          },
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .registeremail_cpwd,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black87),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
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
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          controller: _confirmController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .registeremail_pcpwd;
                                            }
                                            if (value != _password) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .registeremail_ipwd;
                                            }

                                            // Return null if the entered email is valid
                                            return null;
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              _confirmpassword = value;
                                            });
                                          },
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 0),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 20, vertical: 10),
                  //     child: Form(
                  //       key: _formKey1,
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const SizedBox(
                  //             height: 30,
                  //           ),
                  //           const Text(
                  //             "Input your address",
                  //             style: TextStyle(
                  //               fontSize: 30,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           const SizedBox(
                  //             height: 40,
                  //           ),
                  //           Expanded(
                  //             child: Padding(
                  //               padding: EdgeInsets.zero,
                  //               child: Column(
                  //                 children: [
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       const Text(
                  //                         "Address",
                  //                         style: TextStyle(
                  //                             fontSize: 15,
                  //                             fontWeight: FontWeight.w400,
                  //                             color: Colors.black87),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 5,
                  //                       ),
                  //                       TextFormField(
                  //                         decoration: InputDecoration(
                  //                           contentPadding:
                  //                               const EdgeInsets.symmetric(
                  //                                   vertical: 0,
                  //                                   horizontal: 10),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(
                  //                               color: Colors.grey,
                  //                             ),
                  //                             borderRadius:
                  //                                 BorderRadius.circular(32),
                  //                           ),
                  //                           border: const OutlineInputBorder(
                  //                               borderSide: BorderSide(
                  //                                   color: Colors.grey)),
                  //                         ),
                  //                         controller: _addressController,
                  //                         validator: (value) {
                  //                           if (value == null ||
                  //                               value.trim().isEmpty) {
                  //                             return 'Please enter your address';
                  //                           }
                  //                           return null;
                  //                         },
                  //                         onChanged: (value) =>
                  //                             _address = value,
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 30,
                  //                       )
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       const Text(
                  //                         "City",
                  //                         style: TextStyle(
                  //                             fontSize: 15,
                  //                             fontWeight: FontWeight.w400,
                  //                             color: Colors.black87),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 5,
                  //                       ),
                  //                       TextFormField(
                  //                         decoration: InputDecoration(
                  //                           contentPadding:
                  //                               const EdgeInsets.symmetric(
                  //                                   vertical: 0,
                  //                                   horizontal: 10),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(
                  //                               color: Colors.grey,
                  //                             ),
                  //                             borderRadius:
                  //                                 BorderRadius.circular(32),
                  //                           ),
                  //                           border: const OutlineInputBorder(
                  //                               borderSide: BorderSide(
                  //                                   color: Colors.grey)),
                  //                         ),
                  //                         controller: _cityController,
                  //                         validator: (value) {
                  //                           if (value == null ||
                  //                               value.trim().isEmpty) {
                  //                             return 'Please enter your city';
                  //                           }
                  //                           return null;
                  //                         },
                  //                         onChanged: (value) => _city = value,
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 30,
                  //                       )
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       const Text(
                  //                         "Index",
                  //                         style: TextStyle(
                  //                             fontSize: 15,
                  //                             fontWeight: FontWeight.w400,
                  //                             color: Colors.black87),
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 5,
                  //                       ),
                  //                       TextFormField(
                  //                         decoration: InputDecoration(
                  //                           contentPadding:
                  //                               const EdgeInsets.symmetric(
                  //                                   vertical: 0,
                  //                                   horizontal: 10),
                  //                           enabledBorder: OutlineInputBorder(
                  //                             borderSide: const BorderSide(
                  //                               color: Colors.grey,
                  //                             ),
                  //                             borderRadius:
                  //                                 BorderRadius.circular(32),
                  //                           ),
                  //                           border: const OutlineInputBorder(
                  //                               borderSide: BorderSide(
                  //                                   color: Colors.grey)),
                  //                         ),
                  //                         controller: _indexController,
                  //                         validator: (value) {
                  //                           if (value == null ||
                  //                               value.trim().isEmpty) {
                  //                             return 'Please enter your index';
                  //                           }
                  //                           return null;
                  //                         },
                  //                         onChanged: (value) => _index = value,
                  //                       ),
                  //                       const SizedBox(
                  //                         height: 30,
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: (_loadingStatus)
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xff283488)),
                      strokeWidth: 2)
                  : const SizedBox(
                      height: 0,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: height * 0.07,
                    width: width * 0.9,
                    child: ElevatedButton(
                      onPressed: _loadingStatus ? null : _onNextPage,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff283488)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(83.0),
                            side: const BorderSide(color: Color(0xff283488)),
                          ),
                        ),
                      ),
                      child: Text(
                        (_currentPage != _numPages - 1)
                            ? AppLocalizations.of(context)!.registeremail_next
                            : _loadingStatus
                                ? "Hold on..."
                                : AppLocalizations.of(context)!
                                    .registeremail_register_button,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
