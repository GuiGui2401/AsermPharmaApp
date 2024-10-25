import 'package:asermpharma/src/app.dart';
import 'package:asermpharma/src/settings/settings_controller.dart';
import 'package:asermpharma/src/settings/settings_service.dart';
import 'package:asermpharma/src/start/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _header(context),
            const SizedBox(height: 15.0),
            _inputField(context),
            const SizedBox(height: 5.0),
            _forgotPassword(context),
            const SizedBox(height: 5.0),
            _signup(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        const Image(image: AssetImage("assets/images/logoaserm.png")),
        const SizedBox(height: 15.0),
        const Text(
          "Welcome Back",
          style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF01172D)),
        ),
        Text(
          "Enter your credential to login",
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: const Color(0xFFED700B).withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person, color: Color(0xFF01172D))),
        ),
        const SizedBox(height: 15),
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
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final settingsController = SettingsController(SettingsService());
            await settingsController.loadSettings();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyApp(settingsController: settingsController),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color(0xFFED700B),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Color(0xFF01172D)),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Color(0xFFED700B)),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Color(0xFF01172D)),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupPage(),
                ),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Color(0xFFED700B)),
            ))
      ],
    );
  }
}
