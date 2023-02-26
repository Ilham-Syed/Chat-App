import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading=false;
  final formKey=GlobalKey<FormState>();
  String email="";
  String password="";
  String fullName="";
  AuthSevices authService=AuthSevices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),):SingleChildScrollView(
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
                  const Text("Create your account now to chat and explore",
                    style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400),
                  ),
                  Image.asset("lib/assets/register.png"),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      labelText: "Full Name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onChanged: (val){
                      setState(() {
                        fullName=val;
                        print(email);
                      });
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }else{
                        return "Name cannot be empty";
                      }
                    },
                  ),
                  const SizedBox(height: 10,),
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
                          register();
                        },
                        child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 16),)
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text.rich(
                      TextSpan(
                        text: "Already have an account?  ",

                        style: const TextStyle(color: Colors.black,fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login Now",
                              style: const TextStyle(
                                  color: Colors.black,fontSize: 14,decoration: TextDecoration.underline,fontWeight: FontWeight.w700
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
  register() async{
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading=true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password)
          .then((value) async {
        if (value == true) {
          // saving the shared preference state
          /*await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, const HomePage());*/
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
