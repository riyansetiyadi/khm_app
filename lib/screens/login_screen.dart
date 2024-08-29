import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:khm_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  final String? emailFromRegister;

  const LoginScreen({Key? key, this.emailFromRegister}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  final Uri _url =
      Uri.parse('https://simkhm.id/wonorejo/kosmetik/forget_password.php');

  final Uri url = Uri.parse('https://simkhm.id/wonorejo/pasien/login.php');

  @override
  void initState() {
    _emailController.text = widget.emailFromRegister ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 150,
                fit: BoxFit.contain,
              ),
              Container(
                width: 400,
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Login Menggunakan Email dan Password yang Sudah Didaftarkan',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              'Email',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontSize: 12),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 12.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Text(
                              'Password',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 12.0),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF198754),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: InkWell(
                              onTap: _launchUrl,
                              child: Text(
                                'Lupa Password ??',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: InkWell(
                              onTap: _launchUrl,
                              child: Text(
                                'Klik Untuk Pendaftaran Berobat Online',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () async {
                                final authRead = context.read<AuthProvider>();

                                final result = await authRead.login(
                                    _emailController.text,
                                    _passwordController.text);
                                if (result) {
                                  context.pushReplacement('/');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "Email/Password Salah",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    duration: const Duration(seconds: 3),
                                  ));
                                }
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF198754),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () =>
                                  context.pushReplacement('/register'),
                              child: Text('Registrasi'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF198754),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Tidak dapat memuat $_url');
    }
    if (!await launchUrl(url)) {
      throw Exception('Tidak dapat memuat $url');
    }
  }
}
