
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_new/ui/screens/forget_password_verify_otp.dart';
import 'package:task_manager_new/ui/screens/reset_password.dart';
import 'package:task_manager_new/ui/widgets/screen_background.dart';
class ForgetPasswordVerifyOtp extends StatelessWidget {
  const ForgetPasswordVerifyOtp({super.key});

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
              Text('PIN Verification',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10,),
              Text('A 6 digit OTP sent to your email address',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10,),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(7),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.grey.shade300,
                  selectedColor: Colors.green,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                  appContext: context,

              ),

              const SizedBox(height: 16,),
              FilledButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
              }, child: Icon(Icons.arrow_circle_right_outlined)),
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
