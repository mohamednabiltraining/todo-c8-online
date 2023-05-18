import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c8_online/database/model/User.dart' as MyUser;
import 'package:todo_c8_online/database/my_database.dart';
import 'package:todo_c8_online/ui/components/custom_form_field.dart';
import 'package:todo_c8_online/ui/dialog_utils.dart';
import 'package:todo_c8_online/ui/home/home_screen.dart';
import 'package:todo_c8_online/validation_utils.dart';
import 'package:todo_c8_online/ui/login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController(text: 'Mohamed nabil');

  var emailController = TextEditingController(text: 'nabil@route.com');

  var passwordController = TextEditingController(text: '123456');

  var passwordConfirmationController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFDFECDB),
          image: DecorationImage(
              image: AssetImage('assets/images/auth_pattern.png'),
              fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: Container(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    CustomFormField(
                      controller: nameController,
                      label: 'Full Name',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter full name';
                        }
                      },
                    ),
                    CustomFormField(
                      controller: emailController,
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email';
                        }
                        if(!ValidationUtils.isValidEmail(text)){
                          return 'please enter a valid email';
                        }
                      },
                    ),
                    CustomFormField(
                      controller: passwordController,
                      label: 'Password',
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (text.length < 6) {
                          return 'password should at least 6 chars';
                        }
                      },
                    ),
                    CustomFormField(
                        controller: passwordConfirmationController,
                        label: 'Password Confirmation',
                        keyboardType: TextInputType.text,
                        isPassword: true,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'please enter password-confirmation';
                          }
                          if (passwordController.text != text) {
                            return "password doesn't match";
                          }
                        }),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12)),
                        onPressed: () {
                          register();
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 24),
                        ),
                    ),
                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },child: Text("Already Have Account?"),)

                  ],
                ),
              ),
            ),
          ),
        ));
  }

  FirebaseAuth authService = FirebaseAuth.instance;

  void register()async{// async - await
    if(formKey.currentState?.validate()==false){
      return;
    }

    DialogUtils.showLoadingDialog(context,'Loading...');
    try{
     var result = await authService.createUserWithEmailAndPassword(email: emailController.text,
          password: passwordController.text);

     var myUser = MyUser.User(
       id: result.user?.uid,
       name: nameController.text,
       email: emailController.text
     );
     await MyDataBase.addUser(myUser);
     DialogUtils.hideDialog(context);
     DialogUtils.showMessage(context, 'user registered successfully',
       postActionName: 'ok',
       posAction: (){
        Navigator.pushReplacementNamed(context,HomeScreen.routeName);
       },dismissible: false
     );

    }on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      DialogUtils.showMessage(context, errorMessage,
      postActionName: 'ok');

    } catch (e) {
      DialogUtils.hideDialog(context);
      String errorMessage = 'Something went wrong';
      DialogUtils.showMessage(context, errorMessage,
      postActionName: 'cancel',
        negActionName: 'Try Again',
        negAction: (){
        register();
        }
      );

    }
  }
}
