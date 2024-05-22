import 'package:flutter/material.dart';
import 'package:projekmobile/regist_page.dart';
import 'package:projekmobile/models/hive_database.dart';
import '../../bottom_navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController cUser = TextEditingController();
  TextEditingController cPass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // TODO 2: Color Pallete
      // backgroundColor: const Color(0xfff0f1f5),
      backgroundColor: Color.fromARGB(255, 225, 229, 249),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            height: size.height,
            width: size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    // TODO 1: Add RichText widget
                    child: RichText(
                        text: const TextSpan(
                            text: 'Selamat Datang!',
                            style: TextStyle(
                              fontSize: 36,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                          TextSpan(
                              text: '\n di Rekomendasi Buku',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 24))
                        ])),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 20,
                            offset: const Offset(0, 0),
                          )
                        ]),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Positioned(
                          top: 10,
                          left: 30,
                          child: Text(
                            'Login Disini',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 90,
                            left: 20,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      width: 300,
                                      child: TextFormField(
                                        controller: cUser,
                                        cursorColor: Colors.grey,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.width * .8,
                                  child: const Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )),
                        Positioned(
                            top: 170,
                            left: 20,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.password,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      width: 300,
                                      child: TextFormField(
                                        controller: cPass,
                                        cursorColor: Colors.grey,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.width * .8,
                                  child: const Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildLoginButton(),
                  Positioned(
                      top: 250,
                      left: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            style: ButtonStyle(),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(' Sign up!'),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text(labelButton),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return _commonSubmitButton(
      labelButton: "L O G I N",
      submitCallback: (value) {
        String currentUsername = cUser.value.text;
        String currentPassword = cPass.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;

    found = _hive.checkLogin(username, password);
    // Retrieve the hashed password from your database or storage based on the username
    String? hashedPassword = _hive.getHashedPassword(username);

    if (hashedPassword != null) {
      // Compare the provided password with the hashed password using bcrypt's comparePassword method
      bool isPasswordMatch =
          await _hive.comparePassword(password, hashedPassword);

      if (isPasswordMatch) {
        found = true;
      }
    }
    if (!found) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password Anda Salah!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Berhasil!'),
          backgroundColor: Color.fromARGB(255, 54, 101, 244),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Nav(),
        ),
      );
    }
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
      },
    );
  }
}
