import 'package:flutter/material.dart';
import 'package:task_manager_new/data/services/api_caller.dart';
import 'package:task_manager_new/ui/screens/forget_password_verify_otp.dart';
import 'package:task_manager_new/ui/widgets/screen_background.dart';

import '../../data/utils/urls.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress =true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                key: _formKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150,),
                  Text('Join with us',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: 'Email'
                    ),
                    validator: (String ? value ){
                      if(value == null || value.isEmpty){
                        return 'please enter your email';
                      }
                      final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if(!emailRegExp.hasMatch(value)){
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                        hintText: 'First name'
                    ),
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your first name';
                      }
                      if(value.trim().length < 2){
                        return 'First name must be at least 2 character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                        hintText: 'Last name'
                    ),
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your last name';
                      }
                      if(value.trim().length < 2){
                        return 'Last name must be at least 2 character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                        hintText: 'Mobile'
                    ),
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your mobile number';
                      }
                      if(value.trim().length != 11){
                        return 'Enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password'
                    ),
                    obscureText: true,
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your password';
                      }
                      if(value.length <= 6){
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  Visibility(
                    //visible: !_signUpInProgress ,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _signUp();
                      }
                    }, child: Icon(Icons.arrow_circle_right_outlined)),
                  ),
                  const SizedBox(height: 16,),
                  Center(
                    child: Column(
                      children: [
                        RichText(text: TextSpan(
                            text: "Already have an account?",
                            children: [
                              TextSpan(
                                  text: 'Sign in',
                                  style: TextStyle(
                                    color: Colors.green,
                                  )
                              )
                            ],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _clearTextField(){
    _emailController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
    _passwordController.clear();
  }

  Future<void> _signUp()async{
    setState(() {
      _signUpInProgress = true;
    });
    Map<String,dynamic>requestBody = {
      "email":_emailController.text,
      "firstName":_firstNameController.text,
      "lastName":_lastNameController.text,
      "mobile":_mobileController.text,
      "password":_passwordController.text,
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.registrationUrl,
      body: requestBody,
    );
    setState(() {
      _signUpInProgress = false;
    });

    if(response.isSuccess){
      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sing Up Success'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.responseData['data']),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  void dispose(){
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
