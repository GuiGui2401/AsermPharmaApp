import 'package:asermpharma/src/start/login_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF01172D)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color(0xFFED700B).withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xFF01172D),
                          ),
                          hintStyle: const TextStyle(color: Color(0xFF01172D))),
                      style: const TextStyle(color: Color(0xFF01172D)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color(0xFFED700B).withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xFF01172D),
                          ),
                          hintStyle: const TextStyle(color: Color(0xFF01172D))),
                      style: const TextStyle(color: Color(0xFF01172D)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color(0xFFED700B).withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Color(0xFF01172D),
                          ),
                          hintStyle: const TextStyle(color: Color(0xFF01172D))),
                      style: const TextStyle(color: Color(0xFF01172D)),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color(0xFFED700B).withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Color(0xFF01172D),
                          ),
                          hintStyle: const TextStyle(color: Color(0xFF01172D))),
                      style: const TextStyle(color: Color(0xFF01172D)),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFFED700B),
                      ),
                      child: const Text(
                        "Sign up",
                        style:
                            TextStyle(fontSize: 20, color: Color(0xFF01172D)),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xFF01172D)),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Color(0xFFED700B)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
