import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reporting_kinerja_karyawan/page/admin/admin.dart';

class Loginadmin extends StatefulWidget {
  const Loginadmin({Key? key}) : super(key: key);

  @override
  _LoginadminState createState() => _LoginadminState();
}

class _LoginadminState extends State<Loginadmin> {
  void loginAdmin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[700],
      body: LoginNyaAdmin(),
    );
  }
}

class LoginNyaAdmin extends StatefulWidget {
  const LoginNyaAdmin({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginNyaAdmin> createState() => _LoginNyaAdminState();
}

class _LoginNyaAdminState extends State<LoginNyaAdmin> {
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCradential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCradential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-tidak-ditemukan") {
        print("Tidak ada pengguna pada email ini");
        const SnackBar(content: Text('Pengguna Tidak Ditemukan'));
      }
    }
    return user;
  }

  TextEditingController _emailCotroller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: SizedBox(height: MediaQuery.of(context).size.height * 0.3, child: Image.asset("assets/admin.png")),
          ),
          Text("Login sebagai admin", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900])),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.025,
              bottom: MediaQuery.of(context).size.height * 0.025,
            ),
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.025,
              bottom: MediaQuery.of(context).size.height * 0.025,
            ),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.025,
                    bottom: MediaQuery.of(context).size.height * 0.025,
                  ),
                  child: TextFormField(
                    controller: _emailCotroller,
                    decoration: InputDecoration(
                        hintText: "masukan Email admin",
                        labelText: "Email admin",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.025,
                    bottom: MediaQuery.of(context).size.height * 0.025,
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "masukan Password", labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(email: _emailCotroller.text, password: _passwordController.text, context: context);
                    print(User);

                    if (user != null) {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Admin()));
                    } else {
                      const snackBar = SnackBar(content: Text("pastikan Infomasi login anda benar"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                    setState(() {});
                  },
                  child: Text("masuk", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple[900])),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Color(0xFF4A148C), width: 3), borderRadius: BorderRadius.circular(17))),
                )),
          ),
        ],
      ),
    );
  }
}
