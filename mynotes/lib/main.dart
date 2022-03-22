import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter demo',
    theme: ThemeData(
      primaryColor: Colors.black38,
    ),
    home: const Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email    = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       appBar: AppBar(
         title: Text('Register'),
         backgroundColor: Colors.black38,
       ),
        body: FutureBuilder(
          future:  Firebase.initializeApp(
                      options: DefaultFirebaseOptions.currentPlatform,
             ),
          builder: (context, snapshot) {
            return  Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText:'enter your email'
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText:'enter your password'
                ),
              ),
              TextButton(onPressed: () async{
                   
                   final email = _email.text;
                   final password = _password.text;
                   
                   await FirebaseAuth.instance.createUserWithEmailAndPassword(
                     email: email, 
                     password: password
                 );
              }, child: const Text(
                'Register'
              )),
            ],
          );
          },
          
        ),
     );
  }
}