
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/screens/forget_password_email_verify.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/screen_background.dart';
import 'main_nav_bar_folder.dart';
import 'sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signInProgress = false;


  @override
  Widget build(BuildContext context) {

    void _onTapSignUp(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
    }

    void _onTabForgetPassword(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordEmailVerify()));
    }

    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                key: _formKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 150,),
                  Text('Get Started with',
                  style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
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
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
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
                  const SizedBox(height: 20,),
                  FilledButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _signIn();
                    }
                  }, child: Icon(Icons.arrow_circle_right_outlined)),
                  const SizedBox(height: 35,),
                  Center(
                    child: Column(
                      children: [
                        TextButton(onPressed: _onTabForgetPassword, child: Text('Forget password'),),
                        RichText(text: TextSpan(
                            text: "Don't have an account?",
                            children: [
                              TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                recognizer: TapGestureRecognizer()..onTap = _onTapSignUp
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
    _passwordController.clear();
  }

  Future<void> _signIn()async{
    setState(() {
      _signInProgress = true;
    });
    Map<String,dynamic>requestBody = {
      "email":_emailController.text,
      "password":_passwordController.text,
    };

    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );
    setState(() {
      _signInProgress = false;
    });

    if(response.isSuccess){
      _clearTextField();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sing In Success'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavBarFolder()));
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
    _passwordController.dispose();
    super.dispose();
  }
}
