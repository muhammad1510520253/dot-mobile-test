import 'package:dot_mobile_test/utils/storage_helper.dart';
import 'package:flutter/material.dart';

import '../../utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailErrorMessage = '';
  String? _passwordErrorMessage = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Halaman Login"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue, fontSize: 30),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Masukkan Email Anda',
              ),
              validator: (String? value) {
                setEmailError(null);
                if (value == null || value.isEmpty) {
                  setEmailError('Email tidak boleh kosong');
                } else if (!Helper().isEmail(value)) {
                  setEmailError('Format email salah');
                }
                return _emailErrorMessage;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 30),
            child: TextFormField(
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Masukkan Password Anda'),
              validator: (String? value) {
                setPasswordError(null);
                if (value == null || value.isEmpty) {
                  setPasswordError('Password tidak boleh kosong');
                } else if (value.length < 6) {
                  setPasswordError('Panjang Password minimal 6 karakter');
                } else if (!value.contains(RegExp(r'[A-Z]'))) {
                  setPasswordError('minimal terdapat 1 huruf besar');
                } else if (!value.contains(RegExp(r'[a-z]'))) {
                  setPasswordError('minimal terdapat 1 huruf kecil');
                }
                return _passwordErrorMessage;
              },
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color:
                    _emailErrorMessage == null && _passwordErrorMessage == null
                        ? Colors.blue
                        : Colors.blueGrey,
                borderRadius: BorderRadius.circular(20)),
            child: TextButton(
              onPressed: () {
                if (_emailErrorMessage == null &&
                    _passwordErrorMessage == null) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  setloading(true);
                  Future.delayed(const Duration(seconds: 3), () {
                    StorageHelper.setLoggedIn(
                        _emailController.text, _passwordController.text);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', (Route<dynamic> route) => false);
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Visibility(
                    visible: _isLoading,
                    child: Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(left: 10),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setEmailError(String? value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _emailErrorMessage = value;
      });
    });
  }

  void setPasswordError(String? value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _passwordErrorMessage = value;
      });
    });
  }

  void setloading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }
}
