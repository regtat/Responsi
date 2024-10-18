import 'package:aplikasi_manajemen_kesehatan/bloc/login_bloc.dart';
import 'package:aplikasi_manajemen_kesehatan/helpers/user_info.dart';
import 'package:aplikasi_manajemen_kesehatan/widget/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/ui/registrasi_page.dart';
import 'data_nutrisi_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 252, 42, 42),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(24.0),
          color: const Color.fromARGB(255, 221, 221, 221),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color:Color.fromARGB(255, 252, 42, 42),
                      ),
                    ),
                    const SizedBox(height: 30),
                    _textboxNama(_usernameController, "Username"),
                    const SizedBox(height: 20),
                    _textboxNama(_passwordController, "Password"),
                    const SizedBox(height: 30),
                    _buttonLogin(),
                    const SizedBox(height: 30),
                    _menuRegistrasi(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textboxNama(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      obscureText: label == "Password",
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Use bright red
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Use bright red
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Use bright red
        ),
        labelStyle: const TextStyle(color: Colors.red), // Use bright red
      ),
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _login,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.red, // Use bright red for button
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: const Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Replace with your login logic
      LoginBloc.login(
        email: _usernameController.text,
        password: _passwordController.text,
      ).then((value) async {
        if (value.code == 200) {
          print(value.userID);
          await UserInfo().setToken(value.token!);
          await UserInfo().setUserID(value.userID!);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DataNutrisiPage()),
          );
        } else {
          _showWarningDialog("Login gagal, silahkan coba lagi");
        }
      }, onError: (error) {
        print(error);
        _showWarningDialog("Login gagal, silahkan coba lagi");
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WarningDialog(
        description: message,
      ),
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(color: Color.fromARGB(255, 243, 33, 33)),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
