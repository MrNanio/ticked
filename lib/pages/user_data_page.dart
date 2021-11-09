import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:ticked/services/user_service.dart';
import 'package:ticked/utils/snack_bar.dart';

import 'home_page.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  _UserDataPage createState() => _UserDataPage();
}

class _UserDataPage extends State<UserDataPage> {
  final UserService _user = UserService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isVisible = false;

  final _controller = AdvancedSwitchController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      setState(() => isVisible = _controller.value);
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 100),
                    Text(
                      "uzupełnij dane konta",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("imie",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                        textAlign: TextAlign.left),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ('Pole imię wymagane!');
                        }
                        return null;
                      },
                      controller: nameController,
                      onSaved: (val) {
                        nameController.text = val!;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "nazwisko",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ('Pole nazwisko wymagane!');
                        }
                        return null;
                      },
                      controller: surnameController,
                      onSaved: (val) {
                        surnameController.text = val!;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "numer telefonu",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        obscureText: false,
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return ('Pole numer telefonu wymagane!');
                          }
                          return null;
                        },
                        controller: phoneController,
                        onSaved: (val) {
                          phoneController.text = val!;
                        }),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AdvancedSwitch(
                      controller: _controller,
                      activeColor: Colors.indigo,
                      inactiveColor: Colors.grey,
                      activeChild: const Text('firmowe'),
                      inactiveChild: const Text('prywatne'),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      width: 300,
                      height: 50.0,
                      enabled: true,
                      disabledOpacity: 0.5,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Switch(
                    //   value: isVisible,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       isVisible = value;
                    //     });
                    //   },
                    //   activeTrackColor: Colors.indigo,
                    //   activeColor: Colors.indigoAccent,
                    // ),
                    Visibility(
                      visible: isVisible,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "kod zapisu",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            obscureText: false,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            controller: codeController,
                            onSaved: (val) {
                              codeController.text = val!;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          if (!isVisible) {
                            codeController.text = 'null';
                          }
                          dynamic result = await _user.addUserData(
                              nameController.text,
                              surnameController.text,
                              phoneController.text,
                              codeController.text);

                          if (mounted) {
                            setState(() {
                              loading = false;
                            });
                          }
                          if (result == null) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false,
                            );
                            setState(() {
                              loading = false;
                            });
                          }
                          if (result != null) {
                            CustomSnackBar.showError(
                                context, result.toString());
                          }
                        }
                      },
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: const Text(
                        "dalej",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
