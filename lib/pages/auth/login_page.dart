import 'package:flutter/material.dart';
import 'package:ticked/pages/auth/reset_password_page.dart';
import 'package:ticked/services/auth_service.dart';
import 'package:ticked/utils/loading.dart';
import 'package:ticked/utils/snack_bar.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  const LoginPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "zaloguj się",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "witaj z powrotem",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("adres email",
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
                            controller: emailController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return ('Wprowadź adres email.');
                              }
                              // reg expression for email
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(val)) {
                                return ("Wprowadź adres email w poprawnym formacie.");
                              }
                              return null;
                            },
                            onSaved: (val) {
                              emailController.text = val!;
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
                            "hasło",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            obscureText: true,
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
                            controller: passwordController,
                            validator: (val) {
                              return null;
                            },
                            onSaved: (val) {
                              passwordController.text = val!;
                            },
                          ),
                          const SizedBox(
                            height: 30,
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
                                if (mounted) {
                                  setState(() {
                                    loading = true;
                                  });
                                }
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        emailController.text,
                                        passwordController.text);
                                if (result != null) {
                                  setState(() {
                                    loading = false;
                                  });
                                  CustomSnackBar.showError(
                                      context, result.toString());
                                }
                              }
                            },
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: const Text(
                              "zaloguj się",
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
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Nie masz jeszcze konta? "),
                              GestureDetector(
                                onTap: () {
                                  widget.toggleView();
                                },
                                child: const Text(
                                  "Załóż konto",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResetPasswordPage())),
                                child: const Text(
                                  "Zapomniałeś hasła?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
