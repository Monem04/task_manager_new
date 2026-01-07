
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/screens/forget_password_email_verify.dart';
import '../../data/models/user_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../controllers/auth_controller.dart';
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
              key: _formKey,
              child: Column(
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
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String ? value){
                      if(value == null || value.isEmpty){
                        return 'please enter your password';
                      }
                      if(value.length < 6){
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
                        TextButton(
                          onPressed: _onTabForgetPassword,
                          child: Text('Forget password'),
                        ),
                        RichText(text: TextSpan(
                            text: "Don't have an account? ",
                            children: [
                              TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                  ),
                                recognizer: TapGestureRecognizer()..onTap = _onTapSignUp
                              )
                            ],
                            style: TextStyle(
                              color: Colors.black,
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


  Future<void> _signIn() async {
    // 1. Start loading state
    setState(() {
      _signInProgress = true;
    });

    try {
      Map<String, dynamic> requestBody = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
      };

      // 2. Make API Call
      final ApiResponse response = await ApiCaller.postRequest(
        url: Urls.loginUrl,
        body: requestBody,
      );

      // Check if widget is mounted before using context or setState
      if (!mounted) return;

      if (response.isSuccess) {
        // 3. Handle Success
        UserModel model = UserModel.fromJson(response.responseData['data']);
        String accessToken = response.responseData['token'];

        await AuthController.saveUserData(model, accessToken);
        _clearTextField();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign In Success'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          // Use pushAndRemoveUntil to prevent going back to login
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainNavBarFolder()),
                (route) => false,
          );
        }
      } else {
        // 4. Handle API Error (e.g., wrong password)
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // Use errorMessage from ApiResponse for safety
              content: Text(response.errorMessage ?? 'Login failed! Please check your credentials.'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      // 5. Handle Unexpected Exceptions (e.g., parsing error)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint("✅❌$e");
      }
    } finally {
      // 6. Stop loading state (Always runs)
      if (mounted) {
        setState(() {
          _signInProgress = false;
        });
      }
    }
  }


  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
