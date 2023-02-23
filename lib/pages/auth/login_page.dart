import 'package:chat_app/pages/auth/register_page.dart';
import 'package:chat_app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey=GlobalKey<FormState>();
  String email="";
  String password="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Groupie",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                  const SizedBox(height: 20,),
                  const Text("Login now to see what they are talking",
                  style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400),
                  ),
                  Image.asset("lib/assets/login.png"),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Email",
                      prefixIcon: Icon(
                          Icons.email,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val){
                      setState(() {
                        email=val;
                        print(email);
                      });
                    },
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val!)?null:"Please enter a valid email";
                    },
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    obscureText: true,
                    decoration: textInputDecoration.copyWith(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                        )
                    ),
                    validator: (val){
                      if(val!.length<6){
                        return "Password must be atleast 6 characters";
                      }else{
                        return null;
                      }
                    },
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });
                    },
                  ),
                 SizedBox(
                   width: double.infinity,
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Theme.of(context).primaryColor,
                       elevation: 0,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(30),
                       ),
                     ),
                       onPressed: (){
                       login();
                       },
                       child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 16),)
                   ),
                 ),
                  const SizedBox(height: 10,),
                  Text.rich(
                    TextSpan(
                      text: "Dont have an account?",

                      style: const TextStyle(color: Colors.black,fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Register Here",
                          style: const TextStyle(
                            color: Colors.black,fontSize: 14,
                          ),
                          recognizer: TapGestureRecognizer()..onTap =(){
                            nextScreenReplace(context, const RegisterPage());
                          }
                        ),
                      ],
                    )
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
  login(){}

}
