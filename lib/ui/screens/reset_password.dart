import 'package:flutter/material.dart';
import 'package:task_manager_new/ui/screens/forget_password_verify_otp.dart';
import 'package:task_manager_new/ui/widgets/screen_background.dart';
class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 150,),
              Text('Set Password',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10,),
              Text('Password should be more than 6 letters and combination of letters and numbers',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),
              const SizedBox(height: 16,),
              FilledButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
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
    );
  }
}
