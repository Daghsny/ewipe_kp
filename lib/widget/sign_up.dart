import 'package:ewipe/provider/google_sign.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const FlutterLogo(
            size: 120,
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Hey there, \nWelcome Back',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login to your account to continue',
                style: TextStyle(fontSize: 16),
              )),
          const Spacer(),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.amber,
              onPrimary: Colors.black,
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.blue,
            ),
            label: const Text('Sign Up with Google'),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: const TextSpan(text: 'Already have an account?', children: [
              TextSpan(
                  text: 'log In',
                  style: TextStyle(decoration: TextDecoration.underline))
            ]),
          )
        ],
      ),
    );
  }
}
